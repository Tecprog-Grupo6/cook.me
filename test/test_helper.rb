require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter '/app/assets/'
  add_filter '/app/channels/'
  add_filter "/app/helpers/"
  add_filter '/app/jobs/'
  add_filter '/app/mailers/'
  add_filter 'app/controllers/users/confirmations_controller.rb'
  add_filter 'app/controllers/users/omniauth_callbacks_controller.rb'
  add_filter 'app/controllers/users/passwords_controller.rb'
  add_filter 'app/controllers/users/unlocks_controller.rb'
  add_filter 'app/controllers/recipes_controller.rb'
  add_filter 'app/models/application_record.rb'
  add_filter 'app/models/recipe.rb'
  add_filter 'app/models/user.rb'
  add_group "Controllers", "app/controllers"
  add_group "Models", "app/models"
  #track_files "{app,lib}/**/*.rb"
  track_files "app/**/*.rb"
end
SimpleCov.minimum_coverage 80

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end
