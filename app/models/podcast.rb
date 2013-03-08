class Podcast < ActiveRecord::Base
  attr_accessible :artistname, :feedurl, :flattrhandle, :hoersuppeslug, :name, :slugintern, :twitterhandle, :url
end
