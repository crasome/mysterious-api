require "acceptance_helper"

resource "Sessions" do
  include_context :api

  get "/expenses" do
    let!(:expenses) { create_list :expense, 1 }

    response_field :expenses,  "A collection of expenses"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_collection, name: :expenses
    example_request "Get a list of expenses" do
      expenses.each do |expense|
        expect(json_response[:expenses]).to include include(
          id: expense.id,
          description: expense.description
        )
      end
    end
  end

  get "/expenses/:id" do
    let!(:expense) { create :expense }

    parameter :id,  "Expense id"
    let(:id) { expense.id }

    response_field :expenses,  "Expense resource object"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :expenses
    example_request "Get expense details" do
      expect(json_response[:expenses]).to include(
        id: expense.id,
        description: expense.description
      )
    end
  end

  put "/expenses/:id" do
    let!(:expense) { create :expense, owner: expense_owner }
    let(:expense_owner) { create :user }
    let(:api_user) { expense_owner }

    parameter :expenses,  "Single top-level resource object"
    parameter :id,           "Expense id",           scope: :expenses
    parameter :description,  "Expense description",  scope: :expenses

    let(:id)   { expense.id }
    let(:description) { "Rspec book" }

    response_field :expenses,  "Altered expense"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :expenses
    example_request "Update expense attributes" do
      expense.reload
      expect(expense.description).to eq description
    end
  end

  post "/expenses" do
    parameter :expenses,  "Single top-level resource object"
    parameter :description,  "Expense description",             scope: :expenses
    parameter :time,         "Date and time of the operation",  scope: :expenses
    parameter :amount,       "Amount spend as decimal",         scope: :expenses

    let(:description) { "Ebook purchase" }
    let(:amount) { 9.99 }
    let(:time) { 1.day.ago }

    response_field :expenses,  "Created expense object"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_resource, name: :expenses
    example "Create an expense" do
      expect do
        do_request
      end.to change { Expense.count }.by +1
    end
  end
end
