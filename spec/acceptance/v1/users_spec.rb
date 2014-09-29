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

  post "/users" do
    parameter :users,     "User resource object"
    parameter :email,     "User email",             scope: :users
    parameter :password,  "User desired password",  scope: :users

    let(:email) { "alice@example.com" }
    let(:password) { "secret" }

    response_field :users,  "User resource object"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :users
    example "Register new user" do
      expect do
        do_request
      end.to change { User.count }.by +1
    end

    describe "when validation error occurs", response_fields: [] do
      response_field :errors,  "Errors object"
      response_field :title,   "Summary of the problem",      scope: :errors
      response_field :detail,  "Explanation of the problem",  scope: :errors

      let(:email) { "invalid_email" }

      it_behaves_like :json_compatible
      it_behaves_like :json_api_resource, name: :errors
      example_request "Validation error on update" do
        expect(json_response[:errors]).to include(
          title: /error/,
          detail: /email/
        )
      end
    end
  end
end
