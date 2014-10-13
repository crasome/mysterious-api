require "rails_helper"

describe V1::ExpensesController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "index" do
    let(:resource) { create :expense }
    it_behaves_like :get_collection_request, name: :expenses

    describe "summary" do
      let!(:resource) { create :expense, amount: 9.0 }
      let!(:another) { create :expense, amount: 11.00 }

      let(:meta) { json_response[:meta] }

      it "provides total value spended" do
        do_request
        expect(meta[:total]).to eq "20.0"
      end

      it "provides average value spended" do
        do_request
        expect(meta[:average]).to eq "10.0"
      end
    end

    describe "weekly grouping" do
      let!(:old_expense) { create :expense, time: 2.weeks.ago }
      let!(:new_expense) { create :expense, time: Time.now }

      let(:collection) { json_response[:expenses] }

      it "returns this week expenses" do
        do_request week: 0
        expect(collection).to include include(id: new_expense.id)
        expect(collection).not_to include include(id: old_expense.id)
      end

      it "returns 2 weeks old expenses" do
        do_request week: 2
        expect(collection).not_to include include(id: new_expense.id)
        expect(collection).to include include(id: old_expense.id)
      end
    end

    def do_request(**params)
      get :index, format: :jsonapi, **params
    end
  end

  describe "show" do
    let(:resource) { create :expense }
    it_behaves_like :get_resource_request, name: :expenses

    def do_request
      get :show, format: :jsonapi, id: resource.id
    end
  end

  describe "update" do
    let(:resource) { create :expense }
    let(:changes) { { description: "new description" } }

    it_behaves_like :update_resource_request, name: :expenses

    def do_request
      put :update, format: :jsonapi, id: resource.id, expenses: changes
    end
  end

  describe "destroy" do
    let(:resource) { create :expense }
    it_behaves_like :delete_resource_request, name: :expenses

    def do_request
      delete :destroy, format: :jsonapi, id: resource.id
    end
  end

  describe "create" do
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

    def do_request
      post :create, format: :jsonapi, expenses: attributes
    end
  end
end
