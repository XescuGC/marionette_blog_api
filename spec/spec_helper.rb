require 'rubygems'
require 'simplecov'
require 'factory_girl'

require 'database_cleaner'

ENV["RACK_ENV"] ||= 'test'

require 'rack/test'

require File.expand_path("../../config/environment", __FILE__)

I18n.enforce_available_locales = false

SimpleCov.start

Dir[File.expand_path("../shared/*.rb", __FILE__)].each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner[:moped].db = DB_NAME

  config.before(:suite) do
    DatabaseCleaner[:moped].strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:moped].start
  end

  config.after(:each) do
    DatabaseCleaner[:moped].clean
  end
end
