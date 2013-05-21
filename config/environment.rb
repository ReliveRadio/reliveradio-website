# Load the rails application
require File.expand_path('../application', __FILE__)

Mime::Type.register "text/chapters", :chapters

# Initialize the rails application
Reliveradio::Application.initialize!
