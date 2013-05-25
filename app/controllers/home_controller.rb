require "net/http"

class HomeController < ApplicationController

	caches_page :index

	def index
		@index_info = IndexInfo.all.shift
		respond_to do |format|
			format.html # index.html.erb
			format.js # index.js.erb
		end
	end
end