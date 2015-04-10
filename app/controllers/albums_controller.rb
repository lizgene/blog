class AlbumsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  def index
    @albums = Album.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  # GET /albums/1
  def show
    log_impression
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      # to handle multiple images upload on create
      if params[:images]
        params[:images].each { |image|
          @album.photos.create(image: image)
        }
      end
      flash[:notice] = "Your album has been created."
      redirect_to @album
    else 
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
    if @album.update(album_params)
      # to handle multiple images upload on update when user add more picture
      if params[:images]
        params[:images].each { |image|
          @album.photos.create(image: image)
        }
      end
      flash[:notice] = "Album has been updated."
      redirect_to @album
    else
      render :edit
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def log_impression
    impressionist(@album) 
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find_by_slug(params[:id]) || Album.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:id, :title, :slug, :description, :created_at, :updated_at, photos_attributes: [ :description, :album_id, :image, :id, :created_at, :updated_at, :_destroy ])
  end
end
