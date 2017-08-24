class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user.nil? ? nil : user
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logged_in?
    user = current_user
    return false if user.nil?
    user.session_token == session[:session_token]
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this content"
      redirect_to new_session_url
    end
  end
end
