require 'spec_helper'

describe "Streams" do

	describe "#General" do
	end

	describe "#Mix" do		
		it "should contain a widget to credit the playlist creator" do
			VCR.use_cassette('stream-mix') do
				visit mix_stream_url
				page.should have_content "Das Programm auf diesem Kanal wird von"
			end
		end
		it "it should link to the correct live stream URLs" do
			VCR.use_cassette('stream-mix') do
				visit mix_stream_url
				page.should have_link("Desktop", :href => APP_CONFIG['mix']['desktop_stream_url'])
				page.should have_link("Mobil", :href => APP_CONFIG['mix']['mobile_stream_url'])
			end
		end
	end

	describe "#Technique" do
		it "should contain a widget to credit the playlist creator" do
			VCR.use_cassette('stream-technique') do
				visit technique_stream_url
				page.should have_content "Das Programm auf diesem Kanal wird von"
			end
		end
		it "it should link to the correct live stream URLs" do
			VCR.use_cassette('stream-technique') do
				visit technique_stream_url
				page.should have_link("Desktop", :href => APP_CONFIG['technique']['desktop_stream_url'])
				page.should have_link("Mobil", :href => APP_CONFIG['technique']['mobile_stream_url'])
			end
		end
	end

	describe "#Culture" do
		it "should contain a widget to credit the playlist creator" do
			VCR.use_cassette('stream-culture') do
				visit culture_stream_url
				page.should have_content "Das Programm auf diesem Kanal wird von"
			end
		end
		it "it should link to the correct live stream URLs" do
			VCR.use_cassette('stream-culture') do
				visit culture_stream_url
				page.should have_link("Desktop", :href => APP_CONFIG['culture']['desktop_stream_url'])
				page.should have_link("Mobil", :href => APP_CONFIG['culture']['mobile_stream_url'])
			end
		end
	end
	
end