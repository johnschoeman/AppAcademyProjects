class CatsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :verify_user_owns_cat, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def verify_user_owns_cat
    user = current_user
    return false if user.nil?
    cats_of_user = user.cats
    cat = cats_of_user.where(id: params[:id]).to_a
    if cat.empty?
      flash[:error] = "You are not this cat's owner, you can't edit it."
      redirect_to cats_url
    else
      true
    end
  end
end
