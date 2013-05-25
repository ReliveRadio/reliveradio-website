class IndexInfoController < ApplicationController

  # authentication for backend
  # set good password here for production use!
  http_basic_authenticate_with :name => PasswordHelper.user, :password => PasswordHelper.password

	def edit
    @index_info = IndexInfo.all.shift
    if @index_info.nil?
    	# create new empty info object
    	@index_info = IndexInfo.new(:title => "", :content => "", :display => false)
    	@index_info.save
    end
  end

  # change the data of an existing podcast in DB
  def update
    @index_info = IndexInfo.find(params[:id])
    respond_to do |format|
      if @index_info.update_attributes(params[:index_info])
        # expire index page static page cache
        expire_page "/index.html"
        format.html { render action: "edit", :flash => { :success => "Podcast erfolgreich gespeichert" } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @index_info.errors, status: :unprocessable_entity }
      end
    end
  end



end
