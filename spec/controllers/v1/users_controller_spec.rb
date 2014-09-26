require "rails_helper"

describe V1::UsersController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "show" do
    let!(:resource) { create :user }
    before { get :show, format: :jsonapi, id: resource.id }

    it_behaves_like :get_resource_request, name: :users
  end

  describe "create" do
    before { post :create, format: :jsonapi, users: attributes }
    let(:attributes) do
      {
        email:                  "freddie.mercury@queen.com",
        password:               "secret",
        password_confirmation:  "secret",
      }
    end

    it_behaves_like :create_resource_request, name: :users do
      let(:resource_scope) { User }
      let(:respond_with) { { email: "freddie.mercury@queen.com" } }
    end
  end
end
