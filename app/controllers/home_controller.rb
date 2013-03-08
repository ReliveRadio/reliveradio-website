require "rubygems"
require "json"
require "net/http"
require "uri"

class HomeController < ApplicationController
  def index
	uri = URI.parse("http://programm.reliveradio.de/api/today-info")
	 
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	 
	response = http.request(request)
	 
	if response.code == "200"
	  result = JSON.parse(response.body)
	  @episodes = result
	else
	  puts "ERROR: Could not read todays episode list from server."
	end
  end
end