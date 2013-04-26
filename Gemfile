# for production use:
# bundle install --without=assets --without=dev

source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
# 
# gem 'rails', :git => 'git://github.com/rails/rails.git', :ref => '4aded'
# gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '2-3-stable'
# gem 'rails', :git => 'git://github.com/rails/rails.git', :tag => 'v2.3.5'

gem 'sqlite3', '1.3.7'
gem 'json', '1.7.7'
gem 'feedzirra', :git => 'git://github.com/pauldix/feedzirra.git', :tag => 'v0.2.0.rc2'
gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails', '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'
	gem 'zurb-foundation', '~> 4.0.0'
	gem 'uglifier', '>= 1.0.3'
	gem "font-awesome-rails", '~> 3.0.2.0'
	gem "mediaelement_rails", '0.5.0'
	gem 'jquery-rails', '2.2.1'
	# See https://github.com/sstephenson/execjs#readme for more supported runtimes
	# gem 'therubyracer', :platforms => :ruby
end

group :dev do
	gem 'thin', '1.5.1'
	
	## testing
	gem 'ruby-prof', '0.13.0'
	gem 'test-unit', '2.5.4'
	
	# To use debugger
	gem 'debugger', '1.5.0'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

