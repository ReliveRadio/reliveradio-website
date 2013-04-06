module HomeHelper
	
	def fetch_listeners
		# Listener statistics from xenim network
		
		xenim_statistics = Rails.cache.fetch("xenim_statistics", :expires_in => 30.seconds) do
			uri = URI.parse("http://feeds.streams.xenim.de/live/json/")
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			JSON.parse(response.body)["items"]
		end

		xenim_statistics.each do |podcast|
			if podcast["author_name"] == "Reliveradio"
				return podcast["listener"]
			end
		end
	end

	def fetch_hoersuppe_livepodcasts
		# hoersuppe api returns local dates (CET)

		#Rails.cache.delete("cacheID")
		live_podcasts = Rails.cache.fetch("hoersuppe_live", :expires_in => 1.hour) do
			# read all podcasts that are really live today from the hoersuppe API
			# %F => 2007-11-19
			uri = URI.parse("http://hoersuppe.de/api/?action=getLive&dateEnd="+ Time.now.strftime('%F'))
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			JSON.parse(response.body)["data"]
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

end
