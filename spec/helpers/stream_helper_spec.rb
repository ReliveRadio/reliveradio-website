require 'spec_helper'
require 'active_support/time_with_zone'

describe "StreamHelper" do

	context "#fetch_total_listeners" do
		it "should not return nil" do
			StreamHelper.fetch_total_listeners.should_not be_nil
		end
	end

	context "#fetch_listeners" do
		it "should not return nil" do
			StreamHelper.fetch_listeners('mix').should_not be_nil
		end
	end

	context "#fetch_hoersuppe_livepodcasts" do
		it "should not return nil" do
			StreamHelper.fetch_hoersuppe_livepodcasts.should_not be_nil
		end
		it "should only return episodes in the array that are live now" do
			live_podcasts = StreamHelper.fetch_hoersuppe_livepodcasts
			live_podcasts.each do |podcast|
				(DateTime.parse(podcast["livedate"]) < DateTime.now.utc.in_time_zone("Berlin")) && (DateTime.parse(podcast["livedate"])+(podcast["duration"].to_i.minutes) > DateTime.now.utc.in_time_zone("Berlin"))
			end
		end
	end

	context "#fetch_episode_schedule" do

		before(:all) do
			@episodes = StreamHelper.fetch_episode_schedule(APP_CONFIG['mix']['airtime_url'])
		end

		it "should not be nil" do
			@episodes.should_not be_nil
		end
		it "should not return blank" do
			@episodes.should_not be_blank
		end
		it "should only return episodes in the array that are upcoming" do
			@episodes.each do |episode|
				( episode['ends_locale'] > Time.now ).should == true
			end
		end
		it "should have all episodes marked as not live except the first one" do
			@episodes.first["isLive"].should == true
			@episodes.each_with_index do |episode, i|
				next if i == 0 # skip the first one as it is live 
				episode["isLive"].should == false
			end
		end
		it "should not contain an episodes with an artistname = jingle" do
			@episodes.each do |episode|
				episode["artist_name"].should_not == "jingle"
			end
		end
		it "should add a duration to all the episodes" do
			@episodes.each do |episode|
				episode["duration"].should_not be_blank
			end
		end
	end

end