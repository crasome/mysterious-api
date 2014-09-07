require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    include_context :json

    it_behaves_like :ok_request
    it_behaves_like :public_request
    it_behaves_like :json_api_collection do
      let(:resource_name) { :users }
    end

    it "includes users" do
      users = create_list :user, 2

      do_request
      users.each do |user|
        expect(json_response[:users]).to include include(email: user.email)
      end
    end
  end

  get "/users/:id" do
    include_context :json
    let(:id) { user.id }

    it_behaves_like :ok_request
    it_behaves_like :public_request
    it_behaves_like :json_api_resource do
      let(:resource_name) { :users }
    end
  end
end
