class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    commentable_id = params[:user_id] || params[:goal_id]
    @comment.commentable_id = commentable_id
    @comment.commentable_type = 'User' if params[:user_id]
    @comment.commentable_type = 'Goal' if params[:goal_id]
    # byebug
    if @comment.save
      # if !params[:user_id].nil?
      #   redirect_to user_id(params[:user_id])
      # elsif !params[:goal_id].nil!
      #   redirect_to goal_id(params[:goal_id])
      # end
      redirect_to_user_or_goal
    else
      flash[:errors] = @comment.errors.full_messages
      # if !params[:user_id].nil?
      #   redirect_to user_id(params[:user_id])
      # elsif !params[:goal_id].nil!
      #   redirect_to goal_id(params[:goal_id])
      # end
      redirect_to_user_or_goal
    end
  end

  def destroy
  end

  private

  def redirect_to_user_or_goal
    if !params[:user_id].nil?
      redirect_to user_url(params[:user_id])
    elsif !params[:goal_id].nil?
      redirect_to goal_url(params[:goal_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
