require 'spec_helper' 

describe PodcastsController do

	# login to http basic auth
	include AuthHelper
	before(:each) do
		http_login
	end

	describe "GET #index" do
		it "should be successful" do
			get :index
			response.should be_success
		end
		it "populates an array of podcasts" do
			p = FactoryGirl.create(:podcast)
			get :index
			# assigns reports @podcasts from the controller method
			assigns[:podcasts].should == [p]
		end
		it "renders the :index view template" do
			get :index
			response.should render_template(:index)
		end
	end

	describe "GET #show" do
		it "assigns the requested contact to @contact"
		it "renders the :show template"
	end

	describe "GET #new" do
		it "assigns a new Contact to @contact"
		it "renders the :new template"
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "saves the new contact in the database"
			it "redirects to the home page"
		end
		context "with invalid attributes" do
			it "does not save the new contact in the database"
			it "re-renders the :new template"
		end
	end 

end