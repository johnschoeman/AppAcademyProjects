class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :current_user
  helper_method :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !current_user.nil?
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this content"
      redirect_to new_session_url
    end
  end
end
