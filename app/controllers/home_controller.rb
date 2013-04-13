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
		# fetch episode schedule
		@episodes = fetch_episode_schedule
		@live_episode = @episodes.shift # returns the first element and removes it from the list

		respond_to do |format|
			format.html # index.html.erb
			format.js # index.js.erb
		end

	end
end