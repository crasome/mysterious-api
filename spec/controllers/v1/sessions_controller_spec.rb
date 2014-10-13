require "rails_helper"

describe V1::SessionsController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

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

    def do_request
      post :create, format: :jsonapi, sessions: attributes
    end
  end
end
