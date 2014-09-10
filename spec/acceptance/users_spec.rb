require "acceptance_helper"

resource "Users" do
  let(:api_user) { create :user }
  around { |spec| as api_user, &spec }

  get "/users" do
    # TODO: generate automatically. See https://github.com/zipmark/rspec_api_documentation/pull/149
    response_field :users,  "A collection of user resource objects"
    response_field :id,     "User id",     scope: :users
    response_field :email,  "User email",  scope: :users

    let!(:users) { create_list :user, 1 }

    include_context :json
    it_behaves_like :ok_request
    it_behaves_like :publicly_accessible_request
    it_behaves_like :restricted_request, rejected_roles: []  do
      let(:resource) { users }
    end

    it_behaves_like :json_api_collection do
      let(:resource_name) { :users }
    end

    example_request "includes users" do
      users.each do |user|
        expect(json_response[:users]).to include include(
          email: user.email
        )
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

    include_context :json
    it_behaves_like :ok_request
    it_behaves_like :publicly_accessible_request
    it_behaves_like :restricted_request, rejected_roles: []  do
      let(:resource) { user }
    end

    it_behaves_like :json_api_resource do
      let(:resource_name) { :users }
    end

    example_request "returns user information" do
      expect(json_response[:users]).to include(
        email: user.email,
        id: user.id
      )
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

    include_context :json
    it_behaves_like :ok_request
    it_behaves_like :publicly_accessible_request
    it_behaves_like :json_api_resource do
      let(:resource_name) { :users }
    end
    it_behaves_like :restricted_request, allowed_roles: [:admin, :owner]  do
      let(:resource) { user }
    end

    example_request "updates user attributes" do
      user.reload
      expect(user.email).to eq "alice@example.com"
    end

    example_request "returns altered user object" do
      user.reload
      expect(json_response[:users]).to include(
        id: user.id,
        email: user.email
      )
    end

    describe "when validation error occurs" do
      response_field :errors,  "Errors object"
      response_field :title,   "Summary of the problem",      scope: :errors
      response_field :detail,  "Explanation of the problem",  scope: :errors

      let(:email) { "invalid_email" }

      it_behaves_like :invalid_attributes_request
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
