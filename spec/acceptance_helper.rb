require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json, :combined_text, :html]
  config.curl_host = 'http://localhost:3000'
  config.api_name = "Mysterious App API"
  config.post_body_formatter = :json
end

RSpec.configure do |config|
  config.include SpecHelpers::JsonResponse
  config.include SpecHelpers::Authentication
end
