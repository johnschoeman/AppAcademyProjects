class SubsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    if current_user == @sub.moderator
      render :edit
    else
      redirect_to sub_url(@sub)
    end
  end

  def update
    @sub = Sub.find(params[:id])
    return redirect_to sub_url(@sub) unless current_user.id == @sub.moderator_id

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
