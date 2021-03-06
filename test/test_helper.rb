ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  ActiveRecord::Migration.maintain_test_schema!

  # Add more helper methods to be used by all tests here...
end
class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

require 'mocha/mini_test'