require 'spec_helper'

describe StreamController do

	describe "GET #mix" do
		it "should be successful" do
			get :mix
			response.should be_success
		end
		it "renders the :mix view template" do
			get :mix
			response.should render_template(:mix)
		end
		it "assigns external api variables" do
		 	get :mix
		 	assigns[:listeners].should_not be_blank
		 	assigns[:live_podcasts].should_not be_nil	
		 	assigns[:episodes].should_not be_blank
		 	assigns[:live_episode].should_not be_blank
		end
	end

	describe "GET #technique" do
		it "should be successful" do
			get :technique
			response.should be_success
		end
		it "renders the :technique view template" do
			get :technique
			response.should render_template(:technique)
		end
		it "assigns external api variables" do
		 	get :mix
		 	assigns[:listeners].should_not be_blank
		 	assigns[:live_podcasts].should_not be_nil
		 	assigns[:episodes].should_not be_blank
		 	assigns[:live_episode].should_not be_blank
		end
	end

	describe "GET #culture" do
		it "should be successful" do
			get :culture
			response.should be_success
		end
		it "renders the :culture view template" do
			get :culture
			response.should render_template(:culture)
		end
		it "assigns external api variables" do
		 	get :mix
		 	assigns[:listeners].should_not be_blank
		 	assigns[:live_podcasts].should_not be_nil
		 	assigns[:episodes].should_not be_blank
		 	assigns[:live_episode].should_not be_blank
		end
	end

	describe "GET #listeners_mix JS" do
		it "should be successful" do
			get :listeners_mix, :format => :js
			response.should be_success
		end
		it "assigns the listeners variable" do
		 	get :listeners_mix, :format => :js
		 	assigns[:listeners].should_not be_nil
		end
	end

	describe "GET #listeners_technique JS" do
		it "should be successful" do
			get :listeners_technique, :format => :js
			response.should be_success
		end
		it "assigns the listeners variable" do
		 	get :listeners_technique, :format => :js
		 	assigns[:listeners].should_not be_nil
		end
	end

	describe "GET #listeners_culture JS" do
		it "should be successful" do
			get :listeners_culture, :format => :js
			response.should be_success
		end
		it "assigns the listeners variable" do
		 	get :listeners_culture, :format => :js
		 	assigns[:listeners].should_not be_nil
		end
	end

	describe "GET #hoersuppe JS" do
		it "should be successful" do
			get :hoersuppe, :format => :js
			response.should be_success
		end
		it "assigns the listeners variable" do
		 	get :hoersuppe, :format => :js
		 	assigns[:live_podcasts].should_not be_nil
		end
	end
end