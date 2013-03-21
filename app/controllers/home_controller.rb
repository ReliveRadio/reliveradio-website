require "net/http"

class HomeController < ApplicationController

	caches_action :index, :expires_in => 60.seconds, :cache_path => 'index'

	def index

		#Rails.cache.delete("cacheID")
		@episodes = Rails.cache.fetch("airtime_schedule", :expires_in => 10.minutes) do
			# read the program for today via GET request as JSON from the Airtime radio API
			uri = URI.parse("http://programm.reliveradio.de/api/today-info")
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			JSON.parse(response.body)
		end

		if !@episodes.blank?
			# remove all passed podcasts from the episodes array
			@episodes.delete_if { |episode| Time.parse(episode["ends"])+1.hour < Time.now }

			# add some more metadata to episodes array
			@episodes.each do |episode|
				# set all to not being live (first one will be set to live after this iterator)
				episode["isLive"] = false;

				# adjust time
				starts = Time.parse(episode["starts"]) + 1.hour
				ends = Time.parse(episode["ends"]) + 1.hour
				episode["starts"] = starts
				episode["ends"] = ends
				# calculate the duration of this episode
				episode["duration"] = ((ends - starts) / 60).round

				# add database information to this object to easily access that in view
				episode["db"] = Podcast.where(["artistname = ?", episode['artist_name']]).first
			end

			# first episode in array is live!
			@episodes.first["isLive"] = true;
		end

	end
end