class AlbumsController < ApplicationController

  def new
    @band = Band.find_by(id: params[:band_id])
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)
    # @band = Band.find(params[:band_id])

    # @album.band_id = @band.id
    # album.band = @band

    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(@band)
      # render json: ['Invalid album parameters!']
    end
  end

  def edit

  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def update

  end

  def destroy
    album = Album.find_by(id: params[:id])
    band = album.band
    album.destroy
    redirect_to band_url(band)
  end

  private
  def album_params
    params.require(:album).permit(:title, :year, :live?, :band_id)
  end

end
