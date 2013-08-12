require 'spec_helper'

describe "Streams" do

	describe "#General" do
		it "should contain a widget to credit the playlist creator" do
			visit mix_stream_url
			page.should have_content "Das Programm auf diesem Kanal wird von"
		end
	end

	describe "#Mix" do
		
	end

	describe "#Technique" do
		
	end

	describe "#Culture" do
		
	end
	
end