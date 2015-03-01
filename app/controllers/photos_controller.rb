class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  def show
  end


  def new
    @photo = Photo.new
  end


  def edit
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.save
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :image, :id, :created_at, :updated_at)
    end
end
