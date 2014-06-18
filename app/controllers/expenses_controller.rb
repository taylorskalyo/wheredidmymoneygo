class ExpensesController < ApplicationController
  def new
  end

  def create
    @expense = Expense.new(expense_params)
	@expense.category = params[:new_category] unless params[:new_category].empty?
    
    @expense.save
      redirect_to @expense
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def index
    @expenses = Expense.all
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :date, :category, :description)
  end

end

