require 'spec_helper'

describe Podcast do

	it "has a valid factory" do
	 	FactoryGirl.create(:podcast).should be_valid
	end

	it "is invalid without an artistname" do
	    p = FactoryGirl.create(:podcast)
	    p.artistname = nil
	    p.should_not be_valid
	end

	it "is invalid without a name" do
	   
	end

	it "is invalid without a feedurl" do
	  
	end

	it "is invalid without a slugintern" do
	  
	end

	it "is invalid without an URL" do
	  
	end

	it "is invalid without a description" do
	  
	end
end