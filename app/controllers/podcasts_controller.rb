require 'feedzirra'

class PodcastsController < ApplicationController

  http_basic_authenticate_with :name => "test", :password => "test", :except => ["info", "overview"]

  def overview
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # overview.html.erb
      format.json { render json: @podcasts }
    end
  end

  def info
    @podcast = Podcast.where(["slugintern = ?", params[:slugintern]]).first

    respond_to do |format|
      format.html # info.html.erb
      format.json { render json: @podcast }
    end   
  end

  def import
    Podcast.import(params[:file])
    redirect_to podcasts_path, notice: "Daten erfolgreich importiert"
  end

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
      format.csv { send_data Podcast.to_csv }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/new
  # GET /podcasts/new.json
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/1/edit
  def edit
    @podcast = Podcast.find(params[:id])
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(params[:podcast])

    if params[:import_from_feed]
      respond_to do |format|
        if @podcast.save
          feed = Feedzirra::Feed.fetch_and_parse(@podcast.feedurl)
          @podcast.description = feed.itunes_summary
          @podcast.save
          format.html { redirect_to edit_podcast_path(@podcast), notice: 'Neuer Podcast angelegt und Beschreibung erfolgreich aus dem Feed importiert' }
          format.json { head :no_content }
        else
          format.html { render action: "new" }
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
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

  # PUT /podcasts/1
  # PUT /podcasts/1.json
  def update
    @podcast = Podcast.find(params[:id])

    if params[:import_from_feed]
      respond_to do |format|
        if @podcast.update_attributes(params[:podcast])
          feed = Feedzirra::Feed.fetch_and_parse(@podcast.feedurl)
          @podcast.description = feed.itunes_summary
          @podcast.save
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

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
end
