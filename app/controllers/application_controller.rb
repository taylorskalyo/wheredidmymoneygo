class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user,
    :logged_in?,
    :remember_page,
    :remember_referer,
    :remembered_page

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil
  end

  def logged_in?
    return true if current_user
  end

  def remember_page
    session[:return_to] = request.url
  end

  # NOTE: Use this function sparingly. If two pages both link to each other
  #  and remember their referer, the user can get stuck in a loop.
  def remember_referer
    session[:return_to] = request.referer
  end

  def remembered_page
    return session.delete(:return_to)
  end

  def require_session
    return true if logged_in?
    remember_page
    flash[:failure] = "You must be logged in to do that"
    redirect_to login_path and return false
  end

  def forbid_session
    return true unless logged_in?
    redirect_to overview_expenses_path and return false
  end
end
