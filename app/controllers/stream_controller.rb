require 'feedzirra'

class StreamController < ApplicationController

  caches_action :technique, :expires_in => 60.seconds, :cache_path => 'technique'
  caches_action :culture, :expires_in => 60.seconds, :cache_path => 'culture'
  caches_action :mix, :expires_in => 60.seconds, :cache_path => 'mix'
  caches_action :listeners, :expires_in => 30.seconds, :cache_path => 'listeners'
  caches_action :hoersuppe, :expires_in => 10.minutes, :cache_path => 'hoersuppe'

  def listeners_mix
    @listeners = StreamHelper.fetch_listeners("mix")
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def listeners_technique
    @listeners = StreamHelper.fetch_listeners("technique")
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def listeners_culture
    @listeners = StreamHelper.fetch_listeners("culture")
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def hoersuppe   
    @live_podcasts = StreamHelper.fetch_hoersuppe_livepodcasts
    respond_to do |format|
      format.js # hoersuppe.js.erb
    end
  end

  def render_genre(genre_name, airtime_url)
    # fetch live listeners count
    @listeners = StreamHelper.fetch_listeners(genre_name)
    # fetch really live podcasts
    @live_podcasts = StreamHelper.fetch_hoersuppe_livepodcasts
    # fetch episode schedule
    @episodes = StreamHelper.fetch_episode_schedule(airtime_url)
    @live_episode = @episodes.shift # returns the first element and removes it from the list

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json  { render :json => {:live_episode => @live_episode, 
                                  :upcoming_episodes => @episodes }}
      format.chapters { render 'chapters'}
    end
  end

  def mix
    render_genre "mix", "http://programm.reliveradio.de/api/today-info"
  end

  def technique
    render_genre "technique", "http://programm.reliveradio.de/api/today-info"
  end

  def culture
    render_genre "culture", "http://programm.reliveradio.de/api/today-info"
  end
end
