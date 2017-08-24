class CatRentalRequestsController < ApplicationController
  before_action :verify_user_owns_cat, only: [:approve, :deny]

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    user = current_user
    if user.nil?
      flash[:error] = "You need to be logged in to rent a cat"
      redirect_to new_session_url
    end

    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.user_id = user.id
    
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private

  def verify_user_owns_cat
    user = current_user
    return false if user.nil?
    cat_id = CatRentalRequest.find(params[:id]).cat_id
    # cat = Cat.find(cat_id)
    cats_of_user = user.cats
    cat = cats_of_user.where(id: cat_id).to_a
    if cat.empty?
      flash[:error] = "You are not this cat's owner, you can't approve or deny this cat's rental requests"
      redirect_to cats_url
    else
      true
    end
  end

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end
end
