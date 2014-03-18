# Be sure to restart your server when you modify this file.
#
# add custom elements to feedjira rss parser
# for more itunes feed elements see this link https://github.com/pauldix/feedjira/blob/master/lib/feedzirra/parser/itunes_rss.rb

Feedjira::Parser::RSS.element :"itunes:summary", :as => :itunes_summary
