require 'spec_helper'

describe "StreamHelper" do

	context "#fetch_total_listeners" do
		it "should not return nil" do
			VCR.use_cassette('listeners-total') do
				StreamHelper.fetch_total_listeners.should_not be_nil
			end
		end
	end

	context "#fetch_listeners" do
		it "should not return nil" do
			VCR.use_cassette('listeners-mix') do
				StreamHelper.fetch_listeners('Mix').should_not be_nil
			end
		end
	end

	context "#fetch_hoersuppe_livepodcasts" do
		it "should not return nil" do
			VCR.use_cassette('hoersuppe-api') do
				StreamHelper.fetch_hoersuppe_livepodcasts.should_not be_nil
			end
		end
		it "should only return episodes in the array that are live now" do
			VCR.use_cassette('hoersuppe-api') do
				live_podcasts = StreamHelper.fetch_hoersuppe_livepodcasts
				live_podcasts.each do |podcast|
					(DateTime.parse(podcast["livedate"]) < DateTime.now.utc.in_time_zone("Berlin")) && (DateTime.parse(podcast["livedate"])+(podcast["duration"].to_i.minutes) > DateTime.now.utc.in_time_zone("Berlin"))
				end
			end
		end
	end

	context "#fetch_episode_schedule" do

		context "bad API call" do
			it "should should raise an error if airtime returns an empty episodes list" do
				expect {
					VCR.use_cassette('mix-airtime-empty-episodes-list') do
						@episodes = StreamHelper.fetch_episode_schedule(APP_CONFIG['mix']['airtime_url'])
					end
				}.to raise_error
			end
			it "should should raise an error if airtime returns an episodes list without a live episode" do
				expect {
					VCR.use_cassette('mix-airtime-no-live-episode') do
						@episodes = StreamHelper.fetch_episode_schedule(APP_CONFIG['mix']['airtime_url'])
					end
				}.to raise_error
			end
		end

		context "valid API call" do
			before(:all) do
				VCR.use_cassette('mix-airtime-max20') do
					@episodes = StreamHelper.fetch_episode_schedule(APP_CONFIG['mix']['airtime_url'])
				end
			end

			it "should not be nil" do
				@episodes.should_not be_nil
			end
			it "should not return blank" do
				@episodes.should_not be_blank
			end
			it "should only contain 10 episodes" do
				@episodes.count == 10
			end
			it "should have all episodes marked as not live except the first one" do
				@episodes.first["isLive"].should == true
				@episodes.each_with_index do |episode, i|
					next if i == 0 # skip the first one as it is live 
					episode["isLive"].should == false
				end
			end
			it "should only return episodes in the array that are upcoming or live" do
				puts "timenowgreptag_test" + Time.now.to_s
				@episodes.each do |episode|
					( episode['ends_locale'] > Time.now ).should == true
				end
			end
			it "should only mark an episode as live if it is actually live" do
				puts "timenowgreptag_test" + Time.now.to_s
				@episodes.first["isLive"].should == true
				live_episode = @episodes.first
				# should be started
				(live_episode['starts_locale'] < Time.now).should == true
				# should not have ended yet
				(live_episode['ends_locale'] > Time.now).should == true
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

end