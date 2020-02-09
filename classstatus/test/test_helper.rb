ENV['RAILS_ENV'] ||= 'test'

# Require and start SimpleCov first thing to ensure complete coverage.
require 'simplecov'
SimpleCov.start 'rails' do
  enable_coverage :branch
end
# Avoid unpleasant interactions between Spring, SimpleCov, and eager loading.
Rails.application.eager_load!

require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize_setup do |worker|
    # Setup database(s)
  end

  parallelize_teardown do |worker|
    # Cleanup database(s)
  end

  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
