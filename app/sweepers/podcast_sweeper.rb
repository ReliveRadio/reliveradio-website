class PodcastSweeper < ActionController::Caching::Sweeper
  observe Podcast
  
  def after_save(podcast)
    expire_cache(podcast)
  end
  
  def after_destroy(podcast)
    expire_cache(podcast)
  end
  
  def expire_cache(podcast)
    expire_action 'all_podcasts_database_backend'
    expire_action 'index'
    expire_page :controller => 'podcasts', :action => 'overview'
    expire_page :controller => 'podcasts', :action => 'info', :slugintern => podcast.slugintern
  end
end