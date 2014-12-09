class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  def index
    @photos = Photo.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  # GET /photos/1
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  def create
    params[:photo][:album_id] = params[:album_id] if params[:album_id]

    @photo = Photo.create(photo_params)

    if @photo.save
      render json: { success: true, message: "success" }
    else
      render json: { success: false, message: "fail" }
    end

  end

  # PATCH/PUT /photos/1
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

  # DELETE /photos/1
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
      params.require(:photo).permit(:album_id, :direct_upload_url, :upload, :processed)
    end
end
