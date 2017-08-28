class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_url] = nil
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    current_user.session_token == session[:session_token]
  end
end
