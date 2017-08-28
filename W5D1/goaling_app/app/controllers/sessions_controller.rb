class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if !user.nil?
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] = ["invalid credentials"]
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
