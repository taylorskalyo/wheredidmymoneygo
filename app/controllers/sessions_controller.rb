class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      flash.now[:success] = "You are now logged in"
      redirect_to overview_expenses_path
    else
      flash[:failure] = "Incorrect username or password"
      redirect_to login_path
    end
  end

end
