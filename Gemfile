# for production use:
# bundle install --without=assets --without=dev

source 'https://rubygems.org'

gem 'rails', '~> 3.2.14'
gem 'sqlite3', '~> 1.3.7'
gem 'json', '~> 1.8.0'
gem 'feedzirra', '~> 0.2'
gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails', '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'
	gem 'foundation-rails', '~> 5.1'
	gem 'uglifier', '>= 1.0.3'
	gem "font-awesome-rails", '~> 4.0'
	gem "mediaelement_rails"
	gem 'jquery-rails', '2.2.1'
end

group :dev do
	# alternative test server
	gem 'thin', '~> 1.5.1'
	# To use debugger
	gem 'debugger', '~> 1.6'
	gem 'ruby-prof', '0.13.0'
end

group :test do
	gem 'test-unit', '~> 2.5.4'
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'faker'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'launchy'
	gem 'database_cleaner'
	gem 'vcr'
	gem 'webmock', '< 1.12'
	gem 'timecop'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'