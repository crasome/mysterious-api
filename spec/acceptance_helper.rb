require 'spec_helper'
require 'dotenv'
Dotenv.load
require 'vcr'
require_relative '../application'

Dir.glob("#{File.dirname(__FILE__)}/support/spec_helpers/**/*.rb").each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  config.ignore_localhost = false

  ENV.select { |key, value| key =~ /TWITTER/  }.values.each do |value|
    config.filter_sensitive_data('<TWITTER_CREDENTIALS>') { value }
  end
end

RSpec.configure do |config|
  config.include SpecHelpers::JsonResponse
end
