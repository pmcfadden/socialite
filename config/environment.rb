# Load the rails application
require File.expand_path('../application', __FILE__)
require 'app/middleware/exception_notifier_toggler'

# Initialize the rails application
Socialite::Application.initialize!
