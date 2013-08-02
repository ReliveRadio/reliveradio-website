require 'spec_helper'

describe "Index" do
	it "shows index_info data if display is set to true" do
		index_info = FactoryGirl.create(:index_info)
		visit index_url
		page.should have_content index_info.content
	end
	it "does not show index_info if display is set to false" do
		index_info = FactoryGirl.create(:index_info, display: false)
		visit index_url
		page.should_not have_content index_info.content
	end
end