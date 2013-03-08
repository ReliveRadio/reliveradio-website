require "rubygems"
require "json"
require "net/http"
require "uri"

class HomeController < ApplicationController
  def index
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
	  # the AT means, that we can use this variable also in the corresponding view
	  @episodes = result
	else
	  puts "ERROR: Could not read todays episode list from server."
	end
  end
end