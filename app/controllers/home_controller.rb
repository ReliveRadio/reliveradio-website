require "net/http"

class HomeController < ApplicationController
	
	include HomeHelper

	caches_action :index, :expires_in => 60.seconds, :cache_path => 'index'
	caches_action :listeners, :expires_in => 30.seconds, :cache_path => 'listeners'
	caches_action :hoersuppe, :expires_in => 10.minutes, :cache_path => 'hoersuppe'

	def listeners
		@listeners = fetch_listeners
		respond_to do |format|
			format.js # listeners.js.erb
		end
	end

	def hoersuppe		
		@live_podcasts = fetch_hoersuppe_livepodcasts
		respond_to do |format|
			format.js # hoersuppe.js.erb
		end
	end

	def index

		# fetch live listeners count
		@listeners = fetch_listeners
		# fetch really live podcasts
		@live_podcasts = fetch_hoersuppe_livepodcasts

		# airtime api returns UTC dates

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
			@episodes.delete_if { |episode| DateTime.parse(episode["ends"]).utc.in_time_zone("Berlin") < Time.now.utc.in_time_zone("Berlin") }
			# do not display jingles in the schedule
			@episodes.delete_if { |episode| episode["artistname"] == "jingle" }

			# add some more metadata to episodes array
			@episodes.each do |episode|
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
			@episodes.first["isLive"] = true;
		end

		respond_to do |format|
			format.html # index.html.erb
			format.js # index.js.erb
		end

	end
end