class PostsController < ApplicationController
  def new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.to_a
    @all_hash_comments = @post.comments_by_parent_id
  end

  def upvote
    vote = Vote.find_by(owner_id: current_user.id, votable_id: params[:post_id], votable_type: 'Post')
    if vote.nil?
      Vote.create(owner_id: current_user.id, value: 1, votable_id: params[:post_id], votable_type: "Post" )
    else
      vote.update(owner_id: current_user.id, value: 1, votable_id: params[:post_id], votable_type: "Post")
    end
    redirect_back(fallback_location: subs_url)
  end

  def downvote
    vote = Vote.find_by(owner_id: current_user.id, votable_id: params[:post_id], votable_type: 'Post')
    if vote.nil?
      Vote.create(owner_id: current_user.id, value: -1, votable_id: params[:post_id], votable_type: "Post" )
    else
      vote.update(owner_id: current_user.id, value: -1, votable_id: params[:post_id], votable_type: "Post")
    end
    redirect_back(fallback_location: subs_url)
  end


  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
