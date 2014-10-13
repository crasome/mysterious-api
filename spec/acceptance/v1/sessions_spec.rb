require "acceptance_helper"

resource "Sessions" do
  include_context :api, authenticate: false

  post "/sessions" do
    let!(:user) { create :user }

    parameter :sessions,  "Single top-level resource object"
    parameter :identifier,  "User email",     scope: :sessions
    parameter :password,    "User password",  scope: :sessions

    let(:identifier) { user.email }
    let(:password) { user.password }

    response_field :sessions,  "Session object"

    it_behaves_like :publicly_available
    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :sessions
    example_request "Create session" do
      expect(status).to eq 201
    end

    describe "when authorization failed", response_fields: [] do
      include_context :error

      let(:password) { "invalid_password" }
      example_request "Authorization failure"
    end
  end
end
