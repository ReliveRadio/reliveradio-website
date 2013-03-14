require 'feedzirra'

class PodcastsController < ApplicationController

  # authentication for backend
  # set good password here for production use!
  http_basic_authenticate_with :name => "test", :password => "test", :except => ["info", "overview"]

  # three columns overview over all available podcasts in the DB
  def overview
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # overview.html.erb
      format.json { render json: @podcasts }
    end
  end

  # detail page for a specific podcast
  def info
    @podcast = Podcast.where(["slugintern = ?", params[:slugintern]]).first

    respond_to do |format|
      format.html # info.html.erb
      format.json { render json: @podcast }
    end   
  end

  # import CSV into DB
  # see model for implementation
  def import
    Podcast.import(params[:file])
    redirect_to podcasts_path, notice: "Daten erfolgreich importiert"
  end

  # all podcasts in backend view
  def index
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
      format.csv { send_data Podcast.to_csv }
    end
  end

  # detail view for a podcast in the backend
  def show
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @podcast }
    end
  end

  # create a new podcast in the backend to save in DB
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
  end

  # edit a podcast in the backend
  def edit
    @podcast = Podcast.find(params[:id])
  end

  # post handler after new. creates the new podcast in the DB
  def create
    # create the new podcast object from form data
    @podcast = Podcast.new(params[:podcast])

    # the import feed button was clicked
    if params[:import_from_feed]
      respond_to do |format|
        # save the form data first
        if @podcast.save
          # read the podcast feed
          feed = Feedzirra::Feed.fetch_and_parse(@podcast.feedurl)
          # fetch the itunes summary and save it as podcast description
          @podcast.description = feed.itunes_summary
          @podcast.save
          # redirect to the edit page to mal review possible
          format.html { redirect_to edit_podcast_path(@podcast), notice: 'Neuer Podcast angelegt und Beschreibung erfolgreich aus dem Feed importiert' }
          format.json { head :no_content }
        else
          format.html { render action: "new" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end

    # the default save button was clicked. nothing special about this one
    else
      respond_to do |format|
        if @podcast.save
          format.html { redirect_to @podcast, notice: 'Neuer Podcast angelegt' }
          format.json { head :no_content }
        else
          format.html { render action: "new" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # change the data of an existing podcast in DB
  def update
    @podcast = Podcast.find(params[:id])

    # import feed description button clicked
    if params[:import_from_feed]
      respond_to do |format|
        # save the form data first
        if @podcast.update_attributes(params[:podcast])
          # read the podcast feed
          feed = Feedzirra::Feed.fetch_and_parse(@podcast.feedurl)
          # fetch the itunes summary and save it as podcast description
          @podcast.description = feed.itunes_summary
          @podcast.save
          # redirect to the edit page to mal review possible
          format.html { redirect_to edit_podcast_path(@podcast), notice: 'Beschreibung erfolgreich aus dem Feed importiert' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @podcast.update_attributes(params[:podcast])
          format.html { redirect_to @podcast, notice: 'Podcast erfolgreich gespeichert' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # delete a podcast
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
end
