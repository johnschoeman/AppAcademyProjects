class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    band = Band.new(band_params)

    if band.save
      redirect_to bands_url
    else
      flash[:error] = 'could not create band'
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
    # fail
    render :show
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
