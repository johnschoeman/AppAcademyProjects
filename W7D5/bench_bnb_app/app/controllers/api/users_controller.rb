class Api::UsersController < ApplicationController

  def new
  end

  def show
    begin
      @user = User.find(params[:id])
      if @user
        render :show
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: [e], status: 404
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
