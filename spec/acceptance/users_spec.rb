require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    let!(:users) { create_list :user, 2 }

    include_context :json
    it_should_behave_like :ok_request

    it "includes users" do
      do_request
      expect(json_response).to include :users => []
    end
  end
end
