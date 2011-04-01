source 'http://rubygems.org'

gem 'rails', '3.0.5'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# authentication
# we needed to comment out the use of authentication headers for 401 errors so we froze this gem
gem 'devise'

gem 'hpricot', :group => :development
gem 'ruby_parser', :group => :development
gem 'haml'
gem "rails-settings", :git => "git://github.com/100hz/rails-settings.git"
gem 'kaminari' #pagination
gem 'thin'

# spam filtering
# this gem makes rake db:seed fail so we froze it and edited the vector.rb file in it
gem 'classifier',  :path => "vendor/gems/classifier-1.3.3"
gem 'fast-stemmer'
gem 'madeleine'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails'
  gem 'ruby-debug'
  gem 'rcov'
end

gem 'haml-rails', :group => :development
