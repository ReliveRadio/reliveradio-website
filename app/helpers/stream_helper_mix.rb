module StreamHelperMix

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

	def self.fetch_listeners
		# Listener statistics from xenim network
		
		xenim_statistics = Rails.cache.fetch("xenim_statistics", :expires_in => 30.seconds) do
			fetch_json("http://feeds.streams.xenim.de/live/json/")["items"]
		end

		if !xenim_statistics.blank?
			xenim_statistics.each do |podcast|
				if podcast["author_name"] == "Reliveradio"
					return podcast["listener"]
				end
			end
		end

		return "Konnte nicht ermittelt werden"
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

	def self.fetch_episode_schedule
		# airtime api returns UTC dates

		#Rails.cache.delete("cacheID")
		episodes = Rails.cache.fetch("airtime_schedule", :expires_in => 10.minutes) do
			# read the program for today via GET request as JSON from the Airtime radio API
			fetch_json("http://programm.reliveradio.de/api/today-info")
		end

		if !episodes.blank?
			# remove all passed podcasts from the episodes array
			episodes.delete_if { |episode| DateTime.parse(episode["ends"]).utc.in_time_zone("Berlin") < Time.now.utc.in_time_zone("Berlin") }
			# do not display jingles in the schedule
			episodes.delete_if { |episode| episode["artistname"] == "jingle" }

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
