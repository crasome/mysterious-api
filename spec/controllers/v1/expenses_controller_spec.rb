require "rails_helper"

describe V1::ExpensesController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "index" do
    let!(:resource) { create :expense }
    before { get :index, format: :jsonapi }

    it_behaves_like :get_collection_request, name: :expenses
  end

  describe "show" do
    let!(:resource) { create :expense }
    before { get :show, format: :jsonapi, id: resource.id }

    it_behaves_like :get_resource_request, name: :expenses
  end

  describe "update" do
    let!(:resource) { create :expense }
    let(:changes) { { description: "new description" } }
    before { put :update, format: :jsonapi, id: resource.id, expenses: changes }

    it_behaves_like :update_resource_request, name: :expenses
  end

  describe "create" do
    before { post :create, format: :jsonapi, expenses: attributes }
    let(:attributes) do
      {
        description:  "Vimcasts",
        time:         1.day.ago,
        amount:       9.99,
        comment:      "Monthly fee",
      }
    end

    it_behaves_like :create_resource_request, name: :expenses do
      let(:resource_scope) { user.expenses }
      let(:respond_with) { { description: "Vimcasts" } }
    end
  end
end
