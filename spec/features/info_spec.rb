require 'spec_helper'

describe "Info" do
	context "Downloads" do
		it "should contain a link to the help page" do
			visit downloads_url
			page.should have_link("Bringe dich ein", :href => help_url)
		end
	end
end