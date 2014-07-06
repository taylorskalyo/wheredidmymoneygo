class ExpensesController < ApplicationController

  before_filter :require_session
  before_filter :remember_referer, :only => [:new, :edit, :destroy]

  helper_method :user_categories

  def new
    @expense = Expense.new
  end

  def create
    @user ||= current_user
    @expense = @user.expenses.create(expense_params)
    use_new_category
    if @expense.save
      redirect_to remembered_page || overview_expenses_path
    else
      render :new
    end
  end

  def edit
    @expense = current_user.expenses.find_by_id(params[:id])
  end

  def update
    @expense = current_user.expenses.find_by_id(params[:id])
    @expense.attributes = expense_params
    use_new_category
    if @expense.save
      redirect_to remembered_page || overview_expenses_path
    else
      render :edit
    end
  end

  def show
    @expense = current_user.expenses.find_by_id(params[:id])
  end

  def index
    @expenses = current_user.expenses.order(date: :desc)
  end

  def overview
    @expenses = current_user.expenses.order(date: :desc).limit(14)
  end

  # TODO: Add more charts. PRIORITY: High
  def charts
    @expenses = current_user.expenses.order(date: :desc)
  end

  def destroy
    @expense = current_user.expenses.find_by_id(params[:id])
    @expense.destroy

    redirect_to remembered_page || overview_expenses_path
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

