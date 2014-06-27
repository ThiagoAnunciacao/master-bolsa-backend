ENV["RACK_ENV"] ||= "test"

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.configure do
    coverage_dir File.join((ENV["CIRCLE_ARTIFACTS"] || "."), "coverage")
  end

  SimpleCov.start "rails" do
    refuse_coverage_drop
  end
end

require "active_record"
require "factory_girl"
require "database_cleaner"
require "rack/test"
require "shoulda-matchers"

require File.expand_path("../../config/application", __FILE__)

def app
  ApplicationController
end

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each do |file|
  require file
end

I18n.config.enforce_available_locales = true

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
ActionMailer::Base.delivery_method = :test

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include Rack::Test::Methods,
    type: :request,
    example_group: { file_path: /spec\/controllers/ }

  config.include JsonHelper,
      type: :request,
      example_group: { file_path: /spec\/controllers/ }

  config.include FactoryGirl::Syntax::Methods

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
