require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do

    include_context :json
    it_should_behave_like :ok_request

    it "has users key" do
      do_request
      expect(json_response).to have_key :users
    end

    it "includes users" do
      users = create_list :user, 2

      do_request
      users.each do |user|
        expect(json_response[:users]).to include include(email: user.email)
      end
    end
  end
end
