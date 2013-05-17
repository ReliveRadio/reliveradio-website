require "net/http"

class HomeController < ApplicationController

	def index
		respond_to do |format|
			format.html # index.html.erb
			format.js # index.js.erb
		end
	end
end