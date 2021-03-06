require "acceptance_helper"

resource "Users" do
  include_context :api

  get "/users" do
    # TODO: generate automatically. See https://github.com/zipmark/rspec_api_documentation/pull/149
    response_field :users,  "A collection of user resource objects"
    response_field :id,     "User id",     scope: :users
    response_field :email,  "User email",  scope: :users

    let!(:users) { create_list :user, 1 }

    example_request "Get a list of users"  do
      users.each do |user|
        expect(json_response[:users]).to include include(
          email: user.email
        )
      end
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_collection do
        let(:resource_name) { :users }
      end
    end
  end

  get "/users/:id" do
    parameter :id,  "User id"

    let(:id) { user.id }

    response_field :users,  "User resource object"
    response_field :id,     "User id",     scope: :users
    response_field :email,  "User email",  scope: :users

    let!(:user) { create :user }

    example_request "Get a specific user" do
      expect(json_response[:users]).to include(
        email: user.email,
        id: user.id
      )
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :users }
      end
    end
  end

  put "/users/:id" do
    let(:api_user) { user }

    parameter :users,  "Single top-level resource object"
    parameter :id,     "User id",     scope: :users
    parameter :email,  "User email",  scope: :users

    let(:id)    { user.id }
    let(:email) { "alice@example.com" }

    response_field :users,  "Altered user"
    response_field :id,     "Altered user id",     scope: :users
    response_field :email,  "Altered user email",  scope: :users

    let!(:user) { create :user }

    example_request "Update the user attributes" do
      user.reload
      expect(user.email).to eq "alice@example.com"
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :users }
      end

      example_request "returns altered user object" do
        user.reload
        expect(json_response[:users]).to include(
          id: user.id,
          email: user.email
        )
      end
    end

    describe "when validation error occurs", response_fields: [] do
      response_field :errors,  "Errors object"
      response_field :title,   "Summary of the problem",      scope: :errors
      response_field :detail,  "Explanation of the problem",  scope: :errors

      let(:email) { "invalid_email" }

      example_request "Validation error on update"

      describe "response", :no_doc do
        include_context :json
        include_examples :invalid_attributes_request
        it_behaves_like :json_api_resource do
          let(:resource_name) { :errors }
        end

        example_request "returns error resource" do
          expect(json_response[:errors]).to include(
            title: /error/,
            detail: /email/
          )
        end
      end
    end
  end
end
