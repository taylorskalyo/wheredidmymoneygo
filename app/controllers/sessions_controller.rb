class SessionsController < ApplicationController

  before_filter :forbid_session, :only => [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      flash.now[:success] = "You are now logged in"
      redirect_back_or_default(overview_expenses_path)
    else
      flash[:failure] = "Incorrect username or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
