require_relative "rails_helper"

require 'capybara/rspec'
require 'capybara/rails'
require 'turnip/capybara' # for scopes
require 'vcr' # for scopes

StepHelpers = Module.new
UiInteractions = Module.new

# TODO: autoload helpers
Dir[
  "spec/features/steps/support/**/*.rb",
  "spec/features/steps/helpers/**/*.rb",
  "spec/features/steps/ui_interactions/**/*.rb",
].each { |f| require Rails.root.join f }

Dir[
  "spec/features/steps/**/*_steps.rb",
].each { |f| require Rails.root.join f }

RSpec.configure do |config|
  config.include Capybara::Angular::DSL
  config.include StepHelpers::Page
  # config.include StepHelpers::DeleteRequest

  config.around(:each, :vcr => ->(v){!!v}) do |example|
    cassette_name = [example.metadata[:example_group][:example_group][:description],
      example.metadata[:example_group][:description],
    ].join('/')
    VCR.use_cassette(cassette_name, {}, &example)
  end
end
