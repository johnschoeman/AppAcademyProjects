class ArtworksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @artworks = Artwork.where("artist_id = #{params[:user_id]}")
    @shared_artworks = @user.shared_artworks
    render json: { artist_artworks: @artworks, shared_artworks: @shared_artworks }
  end

  def create
    @artwork = Artwork.new(artwork_params)

    if @artwork.save
      render json: @artwork
    else
      render @artwork.errors.full_messages, status: 422
    end
  end

  def show
    @artwork = Artwork.find(params[:id])
    render json: @artwork
  end

  def update
    @artwork = Artwork.find(params[:id])

    if @artwork.update_attributes(artwork_params)
      render json: @artwork
    else
      render @artwork.errors.full_messages, status: 422
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])

    if @artwork.destroy
      render json: @artworkd
    else
      render @artwork.errors.full_messages, status: 422
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
