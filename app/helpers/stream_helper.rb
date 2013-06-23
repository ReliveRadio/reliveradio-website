module StreamHelper

	require 'timeout'
	require 'net/http'

	def self.fetch_json(url)
		Timeout::timeout(1) do # 1 second
			# operation that may cause a timeout
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			return JSON.parse(response.body)
		end
		rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			return ""
	end

  # fetch listeners count of a specific genre
	def self.fetch_listeners(genre_name)		
		listeners_statistic = Rails.cache.fetch("listeners_json", :expires_in => 30.seconds) do
			fetch_json("http://stream.reliveradio.de:8000/json.xsl")
		end

		listeners = 0
		if !listeners_statistic.blank?
			listeners_statistic["mounts"].each do |mount|
				if mount["genre"].include? genre_name
					listeners += mount["listeners"].to_i
				end
			end
		end

		return listeners
	end

  # fetch total listeners count of all genres
	def self.fetch_total_listeners
		listeners_statistic = Rails.cache.fetch("listeners_json", :expires_in => 30.seconds) do
			fetch_json("http://stream.reliveradio.de:8000/json.xsl")
		end
		return listeners_statistic["total_listeners"]
	end

	def self.fetch_hoersuppe_livepodcasts
		# hoersuppe api returns local dates (CET)

		#Rails.cache.delete("cacheID")
		live_podcasts = Rails.cache.fetch("hoersuppe_live", :expires_in => 1.hour) do
			# read all podcasts that are really live today from the hoersuppe API
			# %F => 2007-11-19
			fetch_json("http://hoersuppe.de/api/?action=getLive&dateEnd="+ Time.now.strftime('%F'))["data"]
		end

		if !live_podcasts.blank?
			# remove all passed podcasts
			live_podcasts.delete_if { |podcast| Time.parse(podcast["livedate"])+(podcast["duration"].to_i.minutes) < Time.now.utc.in_time_zone("Berlin") }
			# remove all not started podcasts
			live_podcasts.delete_if { |podcast| Time.parse(podcast["livedate"]) > Time.now.utc.in_time_zone("Berlin") }
			# this will only keep all podcasts that are LIVE NOW
			
			# add some more metadata to podcasts array
			live_podcasts.each do |podcast|
				# add database information to this object to easily access that in view
				podcast["db"] = Podcast.where(["hoersuppeslug = ?", podcast['podcast']]).first
			end
		end

		return live_podcasts
	end

	def self.fetch_episode_schedule(url)
		episodes_backup = Rails.cache.read(url)
		episodes = Rails.cache.fetch(url, :expires_in => 10.minutes) do
			# read the program for today via GET request as JSON from the Airtime radio API
			newAirtimeJSON = fetch_json(url)
			if newAirtimeJSON.blank?
				# if API fetch did not return valid data, return the old cache state
				episodes_backup
			else
				newAirtimeJSON
			end
		end

		if !episodes.blank?
			# remove all passed podcasts from the episodes array
			episodes.delete_if { |episode| DateTime.parse(episode["ends"]).utc.in_time_zone("Berlin") < Time.now.utc.in_time_zone("Berlin") }
			# do not display jingles in the schedule
			episodes.delete_if { |episode| episode["artist_name"] == "jingle" }

			# add some more metadata to episodes array
			episodes.each do |episode|
				# set all to not being live (first one will be set to live after this iterator)
				episode["isLive"] = false;

				# adjust time
				starts = DateTime.parse(episode["starts"]).utc.in_time_zone("Berlin")
				ends = DateTime.parse(episode["ends"]).utc.in_time_zone("Berlin")
				episode["starts"] = starts
				episode["ends"] = ends
				# calculate the duration of this episode
				episode["duration"] = ((ends - starts) / 60).round

				# add database information to this object to easily access that in view
				episode["db"] = Podcast.where(["artistname = ?", episode['artist_name']]).first
			end

			# first episode in array is live!
			episodes.first["isLive"] = true;
		end

		return episodes
	end

end
