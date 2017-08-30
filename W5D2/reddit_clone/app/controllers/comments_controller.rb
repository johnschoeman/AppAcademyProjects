class CommentsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def upvote
    vote = Vote.find_by(owner_id: current_user.id, votable_id: params[:comment_id], votable_type: 'Comment')
    if vote.nil?
      Vote.create(owner_id: current_user.id, value: 1, votable_id: params[:comment_id], votable_type: "Comment" )
    else
      vote.update(owner_id: current_user.id, value: 1, votable_id: params[:comment_id], votable_type: "Comment")
    end
    redirect_back(fallback_location: subs_url)
  end

  def downvote
    vote = Vote.find_by(owner_id: current_user.id, votable_id: params[:comment_id], votable_type: 'Comment')
    if vote.nil?
      Vote.create(owner_id: current_user.id, value: -1, votable_id: params[:comment_id], votable_type: "Comment" )
    else
      vote.update(owner_id: current_user.id, value: -1, votable_id: params[:comment_id], votable_type: "Comment")
    end
    redirect_back(fallback_location: subs_url)
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
