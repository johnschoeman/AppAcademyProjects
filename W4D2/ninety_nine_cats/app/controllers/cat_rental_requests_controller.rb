class CatRentalRequestsController < ApplicationController

  def create
    @cat_request = CatRentalRequest.new(cat_rental_params)

    if @cat_request.save
      redirect_to cat_rental_request_url(@cat_request)
    else
      render json: @cat_request.errors.full_messages, status: 422
    end
  end

  def approve
    @cat = Cat.find(params[:id])
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
  end

  def deny

    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
  end

  def new
    @cats = Cat.all

    render :new
  end

  def show
    @cat_request = CatRentalRequest.find(params[:id])

    redirect_to cat_url(@cat_request.cat_id)
  end

  private

  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)

  end
end
