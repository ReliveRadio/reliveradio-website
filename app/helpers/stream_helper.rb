module StreamHelper

	require 'active_support/time_with_zone'

  	# fetch listeners count of a specific genre
	def self.fetch_listeners(genre_name)
		listeners_statistic = ExternalApiHelper.fetch_json_with_cache(APP_CONFIG['listeners_url'] + "?" + genre_name, 30.seconds)

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
		listeners_statistic = ExternalApiHelper.fetch_json_with_cache(APP_CONFIG['listeners_url'], 30.seconds)
		return listeners_statistic["total_listeners"]
	end

	def self.fetch_hoersuppe_livepodcasts
		# hoersuppe api returns local dates (CET)

		live_podcasts = ExternalApiHelper.fetch_json_with_cache("http://hoersuppe.de/api/?action=getLive&dateEnd="+ Time.now.strftime('%F'), 1.hour)
		if !live_podcasts.blank?
			live_podcasts = live_podcasts["data"]
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
		end

		return live_podcasts
	end

	def self.fetch_episode_schedule(url)
		episodes = ExternalApiHelper.fetch_json_with_cache(url, 10.minutes)

		if !episodes.blank?
			# remove all passed podcasts from the episodes array
			episodes.delete_if { |episode| ActiveSupport::TimeWithZone.new(Time.parse(episode["ends"]), "Berlin") < ActiveSupport::TimeWithZone.new(Time.now, "Berlin") }
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
			live_episode = episodes.first
			live_episode["isLive"] = true if !live_episode.blank?
		end

		return episodes
	end

end
