require 'spec_helper'

describe PodcastsController do
	it "should route podcast/new" do
	  {get: '/podcasts/new'}.should route_to({controller: 'podcasts', action: 'new'})
	end
end