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
		it "renders the :show template" do
			p = FactoryGirl.create(:podcast)
			get :show, id: p.id
			response.should render_template(:show)
		end
		it "should be successful" do
			p = FactoryGirl.create(:podcast)
			get :show, id: p.id
			response.should be_success
		end
		it "assigns the requested id to @podcast" do
			p = FactoryGirl.create(:podcast)
			get :show, id: p.id
			assigns[:podcast].should_not be_nil
			assigns[:podcast].should be_kind_of(Podcast)
			assigns[:podcast].should == p
		end
		it "should redirect to #index if no podcast can be found for the given id" do
			get :show, id: "some_id_that_is_not_in_database"
			response.should be_success
			response.should redirect_to(podcasts_path)
		end
	end

	describe "GET #new" do
		it "assigns a new Podcast object" do
			get :new
			assigns[:podcast].should_not be_nil
			assigns[:podcast].should be_kind_of(Podcast)
			assigns[:podcast].should be_new_record
		end
		it "renders the :new template" do
			get :new
			response.should render_template(:new)
		end
		it "should be successful" do
			get :new
			response.should be_success
		end
	end

	describe "GET #overview" do
		
	end

	describe "GET #info" do
		
	end

	describe "GET #edit" do
		
	end

	describe "POST #import" do
		
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

	describe "POST #destroy" do
		
	end

	describe "POST #update" do
		
	end

	describe "POST #create" do
		
	end

	describe "POST #import_from_feed" do
		
	end

end