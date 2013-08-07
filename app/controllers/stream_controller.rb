require 'feedzirra'

class StreamController < ApplicationController

  caches_action :technique, :expires_in => 60.seconds, :cache_path => 'technique'
  caches_action :culture, :expires_in => 60.seconds, :cache_path => 'culture'
  caches_action :mix, :expires_in => 60.seconds, :cache_path => 'mix'

  caches_action :listeners_mix, :expires_in => 30.seconds, :cache_path => 'listeners_mix'
  caches_action :listeners_culture, :expires_in => 30.seconds, :cache_path => 'listeners_technique'
  caches_action :listeners_technique, :expires_in => 30.seconds, :cache_path => 'listeners_culture'
  
  caches_action :hoersuppe, :expires_in => 10.minutes, :cache_path => 'hoersuppe'

  def listeners_mix
    @listeners = StreamHelper.fetch_listeners("Mix")
    respond_to do |format|
      format.js { render 'listeners'}
    end
  end

  def listeners_technique
    @listeners = StreamHelper.fetch_listeners("Technik")
    respond_to do |format|
      format.js { render 'listeners'}
    end
  end

  def listeners_culture
    @listeners = StreamHelper.fetch_listeners("Kultur")
    respond_to do |format|
      format.js { render 'listeners'}
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
    @live_episode = @episodes.shift # assume the first episode as live
    respond_to do |format|
      format.html # index.html.erb
      format.js { render 'update_episodes'}
      format.json  { render :json => {:live_episode => @live_episode, 
                                      :upcoming_episodes => @episodes }}
      format.chapters { render 'chapters'}
    end
  end

  def mix
    @desktop_stream_url = APP_CONFIG['mix']['desktop_stream_url']
    @mobile_stream_url = APP_CONFIG['mix']['mobile_stream_url']
    render_genre "Mix", APP_CONFIG['mix']['airtime_url']
  end

  def technique
    @desktop_stream_url = APP_CONFIG['technique']['desktop_stream_url']
    @mobile_stream_url = APP_CONFIG['technique']['mobile_stream_url']
    render_genre "Technik", APP_CONFIG['technique']['airtime_url']
  end

  def culture
    @desktop_stream_url = APP_CONFIG['culture']['desktop_stream_url']
    @mobile_stream_url = APP_CONFIG['culture']['mobile_stream_url']
    render_genre "Kultur", APP_CONFIG['culture']['airtime_url']
  end
end
