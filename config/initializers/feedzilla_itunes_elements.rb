# Be sure to restart your server when you modify this file.
#
# add custom elements to feedzirra rss parser
# for more itunes feed elements see this link https://github.com/pauldix/feedzirra/blob/master/lib/feedzirra/parser/itunes_rss.rb

Feedzirra::Parser::RSS.element :"itunes:summary", :as => :itunes_summary
