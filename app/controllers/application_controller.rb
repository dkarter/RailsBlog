class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id)
  end
end
