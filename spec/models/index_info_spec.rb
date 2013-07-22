require 'spec_helper'

describe IndexInfo do

	it "has a valid factory" do
	 	FactoryGirl.create(:index_info).should be_valid
	end

	# it "is invalid without content" do
	# 	FactoryGirl.build(:index_info, content: nil).should_not be_valid
	# end

	# it "is invalid without a title" do
	#  	FactoryGirl.build(:index_info, title: nil).should_not be_valid
	# end

end