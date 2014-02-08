require 'spec_helper'

describe InfoController do

	describe "GET #about" do
		it "should be successful" do
			get :about
			response.should be_success
		end
		it "renders the :about view template" do
			get :about
			response.should render_template(:about)
		end
	end

	describe "GET #help" do
		it "should be successful" do
			get :help
			response.should be_success
		end
		it "renders the :help view template" do
			get :help
			response.should render_template(:help)
		end
	end

	describe "GET #chat" do
		it "should be successful" do
			get :chat
			response.should be_success
		end
		it "renders the :chat view template" do
			get :chat
			response.should render_template(:chat)
		end
	end

	describe "GET #downloads" do
		it "should be successful" do
			get :downloads
			response.should be_success
		end
		it "renders the :downloads view template" do
			get :downloads
			response.should render_template(:downloads)
		end
	end

	describe "GET #faq" do
		it "should be successful" do
			get :faq
			response.should be_success
		end
		it "renders the :faq view template" do
			get :faq
			response.should render_template(:faq)
		end
	end

end