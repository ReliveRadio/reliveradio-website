require "net/http"

class HomeController < ApplicationController
  def index

  	# TODO: add caching. for more info see this URL http://guides.rubyonrails.org/caching_with_rails.html

	# read the program for today via GET request as JSON from the Airtime radio API
	uri = URI.parse("http://programm.reliveradio.de/api/today-info")
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)

	# check if HTTP request worked
	if response.code == "200"
		# parse JSON
		result = JSON.parse(response.body)
		# save received episodes into episodes object
		@episodes = result

		now_time = Time.now
		@episodes.delete_if { |episode| Time.parse(episode["ends"])+1.hour < now_time }

		@episodes.each do |episode|
			# adjust time
			episode["starts"] = Time.parse(episode["starts"]) + 1.hour
			episode["ends"] = Time.parse(episode["ends"]) + 1.hour
			# add database information to this object to easily access that in view
			episode["db"] = Podcast.where(["artistname = ?", episode['artist_name']]).first
	  end
	else
		puts "ERROR: Could not read todays episode list from server."
	end
  end
end