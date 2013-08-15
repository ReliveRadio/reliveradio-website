require 'spec_helper'

describe HomeController do

	describe "GET #index" do
		it "should be successful" do
			get :index
			response.should be_success
		end
		it "renders the :index view template" do
			get :index
			response.should render_template(:index)
		end
		it "assigns index_info correct if present" do
			i = FactoryGirl.create(:index_info)
			get :index
			assigns[:index_info] == i
		end
	end
end