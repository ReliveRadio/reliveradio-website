require 'spec_helper'

describe Podcast do

	it "has a valid factory" do
	 	FactoryGirl.create(:podcast).should be_valid
	end

	it "is invalid without an artistname" do
	    FactoryGirl.build(:podcast, artistname: nil).should_not be_valid
	end

	it "is invalid without a name" do
	    FactoryGirl.build(:podcast, name: nil).should_not be_valid   
	end

	it "is invalid without a feedurl" do
	    FactoryGirl.build(:podcast, feedurl: nil).should_not be_valid  
	end

	it "is invalid without a slugintern" do
	    FactoryGirl.build(:podcast, slugintern: nil).should_not be_valid  
	end

	it "is invalid without an URL" do
	    FactoryGirl.build(:podcast, url: nil).should_not be_valid	  
	end

	it "is invalid without a description" do
	    FactoryGirl.build(:podcast, description: nil).should_not be_valid	  
	end
end