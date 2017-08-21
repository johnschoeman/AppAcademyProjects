class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def create
    user = User.new(params[:user].permit(:username, :email))
    # replace the `user_attributes_here` with the actual attribute keys
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render json: @user
    else
      render plain: "user not found in database"
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user
      @user.update_attributes(user_params)
      render json: @user
    else
      render plain: "user not found in database"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if @user
      @user.destroy
      render json: @user
    else
      render plain: "user not found in database"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
