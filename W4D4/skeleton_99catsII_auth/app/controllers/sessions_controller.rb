class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by(username: params[:user][:username])

    if !user.nil? && user.is_password?(params[:user][:password])
      login!(user)
      redirect_to cats_url
    else
      flash[:error] = "Incorrect Username or Password."
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    if !user.nil?
      user.session_token = nil
      session[:session_token] = nil
      redirect_to cats_url
    end
  end
end
