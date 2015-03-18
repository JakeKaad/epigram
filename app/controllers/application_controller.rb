class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user # return true or false
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to do that."
      redirect_to login_path
    end
  end
end
