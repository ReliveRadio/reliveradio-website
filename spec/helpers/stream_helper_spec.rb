require 'spec_helper'

describe StreamHelper do

	# dummy class helper required to call methods of the module
	class DummyClass
	end
	before(:all) do
	  @dummy_class = DummyClass.new
	  @dummy_class.extend(StreamHelper)
	end

	context "#fetch_total_listeners" do
		it "should not return nil" do
			@dummy_class.fetch_total_listeners.should_not be_nil
		end
	end

	context "#fetch_listeners" do
		it "should not return nil" do
			@dummy_class.fetch_listeners('mix').should_not be_nil
		end
	end

	context "#fetch_hoersuppe_livepodcasts" do
		it "should not return nil" do
			@dummy_class.fetch_hoersuppe_livepodcasts.should_not be_nil
		end
		it "should only return episodes in the array that are live now" do
			live_podcasts = @dummy_class.fetch_hoersuppe_livepodcasts
			live_podcasts.each do |podcast|
				(DateTime.parse(podcast["livedate"]) < DateTime.now.utc.in_time_zone("Berlin")) && (DateTime.parse(podcast["livedate"])+(podcast["duration"].to_i.minutes) > DateTime.now.utc.in_time_zone("Berlin"))
			end
		end
	end

	context "#fetch_episode_schedule" do

		before(:all) do
			@episodes = @dummy_class.fetch_episode_schedule('http://mixzentrale.reliveradio.de/api/today-info')
		end

		it "should not return blank" do
			@episodes.should_not be_blank
		end
		it "should only return episodes in the array that are upcoming" do
			@episodes.each do |episode|
				DateTime.parse(episode["ends"]) > DateTime.now.utc.in_time_zone("Berlin")
			end			
		end
		it "should have all episodes marked as not live except the first one" do
			@episodes.first["isLive"] == true
			@episodes.each_with_index do |episode, i|
				next if i == 0 # skip the first one as it is live 
				episode["isLive"] == false
			end
		end
		it "should not contain an episodes with an artistname = jingle" do
			@episodes.each do |episode|
				episode["artist_name"] != "jingle"
			end
		end
		it "should add a duration to all the episodes" do
			@episodes.each do |episode|
				episode["duration"].should_not be_blank
			end
		end
	end

end