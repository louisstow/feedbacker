class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_user_id
  helper_method :logged_in?

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def current_user_id
    session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_login
    unless logged_in?
      redirect_to root_path, notice: "Must be logged in"
    end
  end
end
