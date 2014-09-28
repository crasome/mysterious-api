module V1
  class ExpensesController < ApplicationController
    def index
      load_expenses
      # TODO: use AggretationSerializer
      render json: @expenses, meta: {
        total: @expenses.sum(:amount),
        average: @expenses.average(:amount)
      }
    end

    def show
      load_expense
      render_model @expense
    end

    def update
      load_expense
      build_expense
      @expense.save
      render_model @expense
    end

    def create
      build_expense
      current_user.expenses << @expense
      render_model @expense, status: :created, location: @expense
    end

    private
    def load_expenses
      @expenses = expense_scope
    end

    def load_expense
      @expense = expense_scope.find params[:id]
    end

    def build_expense
      @expense ||= expense_scope.build
      @expense.attributes = expense_params
    end

    def expense_params
      params.require(:expenses).permit(:description, :time, :amount, :comment)
    end

    def expense_scope
      Expense.all
    end
  end
end
