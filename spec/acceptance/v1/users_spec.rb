require "acceptance_helper"

resource "Users" do
  include_context :api
  module ResponseFields
    def self.included(example)
      example.response_field :id,     "User id",     scope: :users
      example.response_field :email,  "User email",  scope: :users
    end
  end

  get "/users/:id" do
    let!(:user) { create :user }

    parameter :id,  "User id"
    let(:id) { user.id }

    response_field :users,  "User resource object"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :users
    example_request "Get user details" do
      expect(json_response[:users]).to include(
        email: user.email,
        id: user.id
      )
    end
  end
end
