require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    include_context :json
    it_should_behave_like :ok_request

    it "includes users" do
      do_request
      expect(response_body).to eq({"users" => []}.to_json)
    end
  end
end
