require_relative "rails_helper"

require 'capybara/rspec'
require 'capybara/rails'
require 'turnip/capybara' # for scopes

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

# RSpec.configure do |config|
#   config.include StepHelpers::DeleteRequest
# end
