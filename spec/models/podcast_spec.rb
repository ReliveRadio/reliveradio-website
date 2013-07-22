require 'spec_helper'

describe Podcast do

	it "has a valid factory" do
	 	FactoryGirl.create(:podcast).should be_valid
	end

	it "is invalid without an artistname" do
	    FactoryGirl.build(:podcast, artistname: nil).should_not be_valid
	end

	it "is invalid without a name" do
	    p = FactoryGirl.create(:podcast)
	    p.name = nil
	    p.should_not be_valid	   
	end

	it "is invalid without a feedurl" do
	    p = FactoryGirl.create(:podcast)
	    p.feedurl = nil
	    p.should_not be_valid	  
	end

	it "is invalid without a slugintern" do
	    p = FactoryGirl.create(:podcast)
	    p.slugintern = nil
	    p.should_not be_valid	  
	end

	it "is invalid without an URL" do
	    p = FactoryGirl.create(:podcast)
	    p.url = nil
	    p.should_not be_valid	  
	end

	it "is invalid without a description" do
	    p = FactoryGirl.create(:podcast)
	    p.description = nil
	    p.should_not be_valid	  
	end
end