require 'spec_helper'

describe PodcastsController do
	it "should route /podcasts/new" do
	  {get: '/podcasts/new'}.should route_to({controller: 'podcasts', action: 'new'})
	end
	it "should route /podcasts" do
	  {get: '/podcasts'}.should route_to({controller: 'podcasts', action: 'index'})
	end
	it "should route /podcasts with POST" do
	  {post: '/podcasts'}.should route_to({controller: 'podcasts', action: 'create'})
	end
end