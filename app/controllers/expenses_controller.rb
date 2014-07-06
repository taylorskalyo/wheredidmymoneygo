class ExpensesController < ApplicationController

  before_filter :require_session

  helper_method :user_categories

  def new
    @expense = Expense.new
    remember_referer
  end

  def create
    @user ||= current_user
    @expense = @user.expenses.create(expense_params)
    use_new_category
    if @expense.save
      redirect_back_or_default(overview_expenses_path)
    else
      render :new
    end
  end

  # TODO: Make sure the user has access before doing anything with an expense
  def edit
    @expense = Expense.find(params[:id])
    remember_referer
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.attributes = expense_params
    use_new_category
    if @expense.save
      redirect_back_or_default(overview_expenses_path)
    else
      render :edit
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def index
    @expenses = current_user.expenses.order(date: :desc)
  end

  def overview
    @expenses = current_user.expenses.order(date: :desc).limit(14)
  end

  def charts
    @expenses = current_user.expenses.order(date: :desc)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_back_or_default(overview_expenses_path)
  end

  def user_categories
    @user ||= current_user
    @user.expenses.select(:category).map(&:category).uniq
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

