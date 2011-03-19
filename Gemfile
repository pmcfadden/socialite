source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# authentication
# we needed to comment out the use of authentication headers for 401 errors so we froze this gem
gem 'devise', :path => "vendor/gems/devise-1.1.7"

gem 'hpricot', :group => :development
gem 'ruby_parser', :group => :development
gem 'haml'

gem "rails-settings", :git => "git://github.com/100hz/rails-settings.git"

# pagination
gem 'kaminari'

# spam filtering
# this gem makes rake db:seed fail so we froze it and edited the vector.rb file in it
gem 'classifier',  :path => "vendor/gems/classifier-1.3.3"
gem 'fast-stemmer'
gem 'madeleine'

#gem 'mongrel'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
 group :development, :test do
   gem 'rspec-rails'
   gem 'ruby-debug'
   gem 'rcov'

   # the following gems are needed to run the browser tests
   #gem "hoe", "2.8.0"
   #gem 'vapir-firefox'
 end

gem 'haml-rails', :group => :development
