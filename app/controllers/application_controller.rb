class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil
  end

  def logged_in?
    return true if current_user
  end

  #TODO: Store current location, not the referer
  def remember_location
    #session[:return_to] ||= request.referer
    session[:return_to] = nil
  end

  def remember_referer
    session[:return_to] ||= request.referer
  end

  def redirect_back_or_default(default)
    raise "Must provide default" if default.blank?
    redirect_to(session.delete(:return_to) || default)
  end

  def require_session
    return true if logged_in?
    remember_location
    flash[:failure] = "You must be logged in to do that"
    redirect_to login_path and return false
  end

  def forbid_session
    return true unless logged_in?
    redirect_to overview_expenses_path and return false
  end
end
