class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    @cat_rentals = @cat.rental_requests.order(:start_date)

    if @cat
      render :show
    else
      render json: @cat.errors.full_messages, status: 422
    end


  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 422
    end

  end

  def edit
    @cat = Cat.find(params[:id])
    if @cat
      render :edit
    else
      render @cat.errors.full_messages, status: 422
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 422
    end
  end

  def new
    render :new
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :description, :sex)
  end
end
