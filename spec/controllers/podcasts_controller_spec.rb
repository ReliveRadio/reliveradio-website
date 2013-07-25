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
		it "renders the :index view template" do
			get :index
			response.should render_template(:index)
		end
		it "populates an array of podcasts" do
			p = FactoryGirl.create(:podcast)
			get :index
			# assigns reports @podcasts from the controller method
			assigns[:podcasts].should == [p]
		end
	end

	describe "GET #show" do
		it "should be successful" do
			p = FactoryGirl.create(:podcast)
			get :show, id: p.id
			response.should be_success
		end
		it "renders the :show template" do
			p = FactoryGirl.create(:podcast)
			get :show, id: p.id
			response.should render_template(:show)
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
			response.should redirect_to(podcasts_path)
			flash[:notice].should =~ /podcast existiert nicht/i
		end
	end

	describe "GET #new" do
		it "should be successful" do
			get :new
			response.should be_success
		end
		it "renders the :new template" do
			get :new
			response.should render_template(:new)
		end
		it "assigns a new Podcast object" do
			get :new
			assigns[:podcast].should_not be_nil
			assigns[:podcast].should be_kind_of(Podcast)
			assigns[:podcast].should be_new_record
		end
	end

	describe "GET #overview" do
		it "should be successful" do
			get :overview
			response.should be_success
		end
		it "renders the :overview view template" do
			get :overview
			response.should render_template(:overview)
		end	
		it "populates an array of podcasts" do
			p = FactoryGirl.create(:podcast)
			get :overview
			assigns[:podcasts].should == [p]
			assigns[:result_count].should == 1
		end
	end

	describe "GET #info" do
		it "should be successful" do
			p = FactoryGirl.create(:podcast)
			get :info, slugintern: p.slugintern
			response.should be_success
		end
		it "renders the :info template" do
			p = FactoryGirl.create(:podcast)
			get :info, slugintern: p.slugintern
			response.should render_template(:info)
		end
		it "assigns the requested slugintern to @podcast" do
			p = FactoryGirl.create(:podcast)
			get :info, slugintern: p.slugintern
			assigns[:podcast].should_not be_nil
			assigns[:podcast].should be_kind_of(Podcast)
			assigns[:podcast].should == p
		end
		it "should redirect to #overview if no podcast can be found for the given slugintern" do
			get :info, slugintern: "some_slugintern_that_is_not_in_database"
			response.should redirect_to(overview_path)
			flash[:notice].should =~ /podcast existiert nicht/i
		end
	end

	# todo! need more tests here
	describe "GET #edit" do
		it "should be successful" do
			p = FactoryGirl.create(:podcast)
			get :edit, id: p.id
			response.should be_success
		end
		it "renders the :edit template" do
			p = FactoryGirl.create(:podcast)
			get :edit, id: p.id
			response.should render_template(:edit)
		end
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

	describe "POST #import" do
		it "should redirect to index action after import"
		it "should show error flash message if import failed"
		it "should show success flash message if import worked"
	end

	describe "POST #import_from_feed" do
		
	end

end