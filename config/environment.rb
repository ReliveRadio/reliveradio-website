# Load the rails application
require File.expand_path('../application', __FILE__)

Mime::Type.register "text/chapters", :chapters

AUTHENTICATION_CONFIG = YAML.load_file("#{Rails.root}/config/authentication.yml")
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")

# Initialize the rails application
Reliveradio::Application.initialize!