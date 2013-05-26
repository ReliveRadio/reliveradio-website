require 'feedzirra'

class StreamController < ApplicationController

  caches_action :technique, :expires_in => 60.seconds, :cache_path => 'technique'
  caches_action :culture, :expires_in => 60.seconds, :cache_path => 'culture'
  caches_action :mix, :expires_in => 60.seconds, :cache_path => 'mix'
  caches_action :listeners, :expires_in => 30.seconds, :cache_path => 'listeners'
  caches_action :hoersuppe, :expires_in => 10.minutes, :cache_path => 'hoersuppe'

  def listeners_mix
    @listeners = StreamHelperMix.fetch_listeners
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def listeners_technique
    @listeners = StreamHelperTechnique.fetch_listeners
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def listeners_culture
    @listeners = StreamHelperCulture.fetch_listeners
    respond_to do |format|
      format.js # listeners.js.erb
    end
  end

  def hoersuppe   
    @live_podcasts = StreamHelperTechnique.fetch_hoersuppe_livepodcasts
    respond_to do |format|
      format.js # hoersuppe.js.erb
    end
  end

  def mix
    # fetch live listeners count
    @listeners = StreamHelperMix.fetch_listeners
    # fetch really live podcasts
    @live_podcasts = StreamHelperMix.fetch_hoersuppe_livepodcasts
    # fetch episode schedule
    @episodes = StreamHelperMix.fetch_episode_schedule
    @live_episode = @episodes.shift # returns the first element and removes it from the list

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json  { render :json => {:live_episode => @live_episode, 
                                  :upcoming_episodes => @episodes }}
      format.chapters { render 'chapters'}
    end
  end

  def technique
    # fetch live listeners count
    @listeners = StreamHelperTechnique.fetch_listeners
    # fetch really live podcasts
    @live_podcasts = StreamHelperTechnique.fetch_hoersuppe_livepodcasts
    # fetch episode schedule
    @episodes = StreamHelperTechnique.fetch_episode_schedule
    @live_episode = @episodes.shift # returns the first element and removes it from the list

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json  { render :json => {:live_episode => @live_episode, 
                                  :upcoming_episodes => @episodes }}
      format.chapters { render 'chapters'}
    end
  end

  def culture
    # fetch live listeners count
    @listeners = StreamHelperCulture.fetch_listeners
    # fetch really live podcasts
    @live_podcasts = StreamHelperCulture.fetch_hoersuppe_livepodcasts
    # fetch episode schedule
    @episodes = StreamHelperCulture.fetch_episode_schedule
    @live_episode = @episodes.shift # returns the first element and removes it from the list

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json  { render :json => {:live_episode => @live_episode, 
                                  :upcoming_episodes => @episodes }}
      format.chapters { render 'chapters'}
    end
  end

end
