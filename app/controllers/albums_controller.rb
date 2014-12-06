class AlbumsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  def index
    @albums = Album.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  # GET /albums/1
  def show
  end

  # GET /albums/new
  def new
    # @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
  end

  # # POST /albums
  # def create
  #   @album = Album.new(album_params)

  #   respond_to do |format|
  #     if @album.save
  #       format.html { redirect_to @album, notice: 'album was successfully created.' }
  #       format.json { render :show, status: :created, location: @album }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @album.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # @http_method XHR POST
  # POST /albums
  def create
    if ! params[:album]
      params[:album] = []
      params[:album][:title] = "New Title"
      params[:album][:description] = "New description"
      params[:album][:photos_attributes] = params[:photos_attributes]
    end

    @album = Album.create(album_params)
  end

  # PATCH/PUT /albums/1
  def update
    photos_attributes = photo_params(params[:photos_attributes], @album.id)
    params[:album][:photos_attributes] = photos_attributes

    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, :cover_photo_id, photos_attributes: [ :album_id, :direct_upload_url, :upload, :processed ])
    end

    def photo_params photos_attributes, album_id
      params = []
      urls = photos_attributes[:urls].split(', ').reject!(&:empty?)

      urls.each_with_index do |url, index|
        params << {url: url, album_id: album_id}
      end
      return params
    end
end