require "rails_helper"

describe V1::UsersController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "show" do
    let(:resource) { create :user }
    it_behaves_like :get_resource_request, name: :users

    def do_request
      get :show, format: :jsonapi, id: resource.id
    end
  end

  describe "create" do
    let(:attributes) do
      {
        email:     "freddie.mercury@queen.com",
        password:  "secret",
      }
    end

    it_behaves_like :create_resource_request, name: :users do
      let(:resource_scope) { User }
      let(:respond_with) { { email: "freddie.mercury@queen.com" } }
    end

    it "can authenticate with same credentials" do
      do_request
      expect(User::Login.authenticate "freddie.mercury@queen.com", "secret").to be
    end

    def do_request
      post :create, format: :jsonapi, users: attributes
    end
  end
end
