require 'spec_helper'

describe "Index" do
	it "should have a link to the impressum page" do
		visit index_url
		page.should have_link("Impressum", :href => 'http://blog.reliveradio.de/impressum/')
	end
	context "IndexInfo" do
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
	context "Links" do
		it "should link to mix stream page" do
			visit index_url
			page.should have_link("Mix", :href => mix_stream_url)
		end
		it "should link to technique stream page" do
			visit index_url
			page.should have_link("Technik", :href => technique_stream_url)
		end
		it "should link to culture stream page" do
			visit index_url
			page.should have_link("Kultur", :href => culture_stream_url)
		end
	end
end