require "rails_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    example "Listing users" do
      do_request
      expect(status).to be 200
    end
  end
end
