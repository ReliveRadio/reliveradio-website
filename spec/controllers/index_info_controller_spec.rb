require 'spec_helper'

describe IndexInfoController do

	# login to http basic auth
	include AuthHelper
	before(:each) do
		http_login
	end

	describe "GET #edit" do
		it "should be successful" do
			i = FactoryGirl.create(:index_info)
			get :edit, id: i.id
			response.should be_success
		end
		it "renders the :edit template" do
			i = FactoryGirl.create(:index_info)
			get :edit, id: i.id
			response.should render_template(:edit)
		end
		it "assigns the correct index_info" do
			i = FactoryGirl.create(:index_info)
			get :edit, id: i.id
			assigns[:index_info] == i
		end
	end

	describe "POST #update" do
		before do
			@i = FactoryGirl.create(:index_info)
			@new_valid_index_info_hash = {index_info: FactoryGirl.attributes_for(:index_info)}
			@update_params = {id: @i.id, index_info: @new_valid_index_info_hash[:index_info]}
		end
		context "with valid attributes" do
			it "should assign the @index_info variable" do
				post :update, @update_params
				assigns[:index_info].should_not be_nil
				assigns[:index_info].should be_kind_of(IndexInfo)
				assigns[:index_info] == @i
			end
			it "does not change number of index_infos in database" do
				lambda{
					post :update, @update_params
				}.should_not change(IndexInfo, :count)
			end
			it "should update the data of the index_info in database" do
				post :update, @update_params
				IndexInfo.find(@i.id) == @new_valid_index_info_hash[:podcast]
			end
			it "rerenders the edit template with success message" do
				post :update, @update_params
				response.should render_template(:edit)
				flash[:success].should =~ /neue daten wurden gespeichert/i
			end
		end
	end

end