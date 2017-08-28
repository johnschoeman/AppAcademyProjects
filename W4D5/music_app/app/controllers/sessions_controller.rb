class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if !user.nil?
      login!(user)
      redirect_to user_url(user)
    else
      flash[:error] = 'Invalid email or password'
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    logout!(user)
    redirect_to new_session_url
  end
end
