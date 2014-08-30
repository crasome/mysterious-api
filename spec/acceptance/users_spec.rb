require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    it "responds with 200" do
      do_request
      expect(status).to be 200
    end

    it "includes users" do
      do_request
      expect(response_body).to eq({"users" => []}.to_json)
    end
  end
end
