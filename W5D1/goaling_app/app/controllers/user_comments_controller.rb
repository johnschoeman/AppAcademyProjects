class UserCommentsController < ApplicationController
  before_action :require_login

  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.author_id = current_user.id
    @user_comment.user_id = params[:user_id]
    if @user_comment.save
      redirect_to user_url(@user_comment.commented_user)
    else
      flash[:errors] = @user_comment.errors.full_messages
      redirect_to user_url(@user_comment.commented_user)
    end
  end

  def destroy
    @user_comment = UserComment.find(params[:id])
    @user_comment.destroy!
    redirect_to user_url(@user_comment.commented_user)
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(:body)
  end
end
