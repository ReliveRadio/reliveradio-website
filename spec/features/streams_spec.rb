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
	end

	describe "#Technique" do
		it "should contain a widget to credit the playlist creator" do
			VCR.use_cassette('stream-technique') do
				visit technique_stream_url
				page.should have_content "Das Programm auf diesem Kanal wird von"
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
	end
	
end