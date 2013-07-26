require 'spec_helper'

describe Podcast do

	context "default model validation" do  
		it "has a valid factory" do
		 	FactoryGirl.build(:podcast).should be_valid
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

	context "searching in podcast database" do  
		it "finds the correct podcasts via search if it exists" do
			p = FactoryGirl.create(:podcast)
			Podcast.search(p.name).should include(p)
		end

		it "returns all podcasts when search is empty" do
			Podcast.search("").should == Podcast.all
		end

		it "returns an empty list if search does not find any matching podcast" do
			Podcast.search("adfglhjaergouhadfgjhdfg").should be_empty
		end
	end

	context "CSV import and export" do
	  	it "raises an error if import file is blank" do
	  	 	expect { Podcast.import() }.to raise_error
	  	end
	end

end