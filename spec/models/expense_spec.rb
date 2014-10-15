require "rails_helper"

describe Expense do
  describe "validity" do
    let(:expense) { create :expense }

    describe "amount" do
      it "is positive" do
        expense.amount = 9.99
        expect(expense).to be_valid

        expense.amount = -9.99
        expect(expense).not_to be_valid
      end

      it "is a number" do
        expense.amount = 9.99
        expect(expense).to be_valid

        expense.amount = "a lot"
        expect(expense).not_to be_valid
      end
    end

    describe "time" do
      it "is a time object" do
        expense.time = Time.now
        expect(expense).to be_valid

        expense.time = "long time ago"
        expect(expense).not_to be_valid
      end
    end
  end
end
