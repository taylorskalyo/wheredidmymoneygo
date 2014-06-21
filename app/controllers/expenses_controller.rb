class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    use_new_category
    if @expense.save
      redirect_to @expense
    else
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.attributes = expense_params
    use_new_category
    if @expense.save
      redirect_to @expense
    else
      render :edit
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def index
    @expenses = Expense.all
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :date, :category, :description)
  end

  def use_new_category
    if expense_params[:category] == "New"
      @expense.category = params[:new_category]
    end
  end

end

