require 'feedzirra'

class PodcastsController < ApplicationController

  include PodcastsHelper

  # authentication for backend
  # set good password here for production use!
  http_basic_authenticate_with :name => PasswordHelper.user, :password => PasswordHelper.password, :except => ["info", "overview"]

  # static page cache for all podcasts overview and detailed view for each podcast
  caches_page :info
  # action cache for all podcasts overview in the backend. action cache needed here to have authentication
  caches_action :index, :cache_path => 'all_podcasts_database_backend'
  # cache sweeper called after specific methods
  cache_sweeper :podcast_sweeper, :only => [:create, :update, :destroy, :import]
  
  # three columns overview over all available podcasts in the DB
  def overview
    @podcasts = Podcast.search(params[:search])
    @result_count = @podcasts.count
    @podcasts = @podcasts.order("name").paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html # overview.html.erb
      format.json { render json: @podcasts }
    end
  end

  # detail page for a specific podcast
  def info
    @podcast = Podcast.where(["slugintern = ?", params[:slugintern]])
    @podcast = @podcast.first if !@podcast.blank?

    if @podcast.blank?
      flash[:notice] = "Dieser Podcast existiert nicht in der Datenbank."
      redirect_to :action => 'overview'
    else
      respond_to do |format|
        format.html # info.html.erb
        format.json { render json: @podcast }
      end
    end
  end

  # import CSV into DB
  # see model for implementation
  def import
    begin
      Podcast.import(params[:file])
      redirect_to podcasts_path, :flash => { :success => "Daten erfolgreich importiert." }
    rescue
      redirect_to podcasts_path, :flash => { :error => "Daten konnten nicht importiert werden." }
    end
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
    begin
      @podcast = Podcast.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @podcast }
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Dieser Podcast existiert nicht in der Datenbank."
      redirect_to :action => 'index'
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
          if import_from_feed(@podcast)
            # redirect to the edit page to make review possible
            format.html { redirect_to edit_podcast_path(@podcast), :flash => { :success => "Beschreibung erfolgreich aus dem Feed importiert" }}
            format.json { head :no_content }
          else
            # redirect to the edit page to mal review possible
            format.html { redirect_to edit_podcast_path(@podcast), :flash => { :error => "Es konnte keine Beschreibung importiert werden" } }
            format.json { head :no_content }
          end 
        else
          format.html { render action: "new" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end

    # the default save button was clicked. nothing special about this one
    else
      respond_to do |format|
        if @podcast.save
          format.html { redirect_to @podcast, :flash => { :success => "Neuer Podcast angelegt und gespeichert." } }
          format.json { head :no_content }
        else
          flash[:error] = "Podcast konnte nicht gespeichert werden. Bitte überprüfe deine Eingaben."
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
          if import_from_feed(@podcast)
            # redirect to the edit page to make review possible
            format.html { redirect_to edit_podcast_path(@podcast), :flash => { :success => "Beschreibung erfolgreich aus dem Feed importiert" }}
            format.json { head :no_content }
          else
            # redirect to the edit page to mal review possible
            format.html { redirect_to edit_podcast_path(@podcast), :flash => { :error => "Es konnte keine Beschreibung importiert werden" } }
            format.json { head :no_content }
          end           
        else
          format.html { render action: "edit" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @podcast.update_attributes(params[:podcast])
          format.html { redirect_to @podcast, :flash => { :success => "Podcast erfolgreich gespeichert" } }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def import_from_feed (podcast)
    # read the podcast feed
    feed = Feedzirra::Feed.fetch_and_parse(podcast.feedurl)

    # fetch the itunes summary and save it as podcast description
    if !feed.nil?
      if feed.respond_to?('itunes_summary') && !feed.itunes_summary.blank?
        podcast.description = feed.itunes_summary
        podcast.save
        return true
      else
        if feed.respond_to?('description') && !feed.description.blank?
          podcast.description = feed.description
          podcast.save
          return true 
        else
          podcast.description = "Keine Beschreibung vorhanden."
          podcast.save
          return false
        end
      end
    else
      podcast.description = "Keine Beschreibung vorhanden."
      podcast.save
      return false
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
