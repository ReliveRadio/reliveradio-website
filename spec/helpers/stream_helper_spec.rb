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
	end

	context "#fetch_episode_schedule" do
		it "should not return nil" do
			@dummy_class.fetch_episode_schedule('http://mixzentrale.reliveradio.de/api/today-info').should_not be_nil
		end
	end

end