require "rails_helper"

describe V1::SessionsController do
  let(:user) { create :user, :registered }

  describe "create" do
    let(:attributes) do
      {
        identifier:  user.email,
        password:    user.password
      }
    end

    it_behaves_like :create_resource_request, name: :sessions, persisted: false do
      let(:respond_with) { { links: include(user: include(email: user.email)) } }
    end

    describe "when login failed" do
      before { attributes[:password] = "invalid_password" }
      it_behaves_like :error_resource do
        let(:respond_with) { { detail: /password/i } }
      end
    end

    def do_request
      post :create, format: :jsonapi, sessions: attributes
    end
  end
end
