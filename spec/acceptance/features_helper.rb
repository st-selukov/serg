require 'rails_helper'
require 'capybara/poltergeist'
require 'capybara/email/rspec'

RSpec.configure do |config|
  config.include AcceptanceHelper, type: :feature

  config.use_transactional_fixtures = false

  Capybara.javascript_driver = :poltergeist

  Capybara.register_driver :poltergeist do |app|
    options = { js_errors: false }
    Capybara::Poltergeist::Driver.new(app, options)
  end

  Capybara.server = :puma
  #
  # config.before(:suite) do
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end
  #
  # config.before(:each, js: true) do
  #   DatabaseCleaner.strategy = :truncation
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end
  #
  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end
end
