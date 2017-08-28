class AlbumsController < ApplicationController

  def new
    @band = Band.find(params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash[:error] = "could not create album"
      redirect_to new_band_album_url(params[:album][:band_id])
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def update

  end

  def destroy

  end



  private

  def album_params
    params.require(:album).permit(:title, :live, :yr, :band_id)
  end
end
