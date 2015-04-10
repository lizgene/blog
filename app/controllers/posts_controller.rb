class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :email_post]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    log_impression
    @checkpoints = @post.checkpoints
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def email_post
    to_emails = params[:to].split(%r{[,\n]+}).collect{|email| email.strip }.uniq
    to_emails.reject!{ |email| email.empty? }

    from_email = params[:from]
    message = params[:message].gsub("\n", "<br />").html_safe

    to_emails.each {|email|
      VisitorMailer.share(email, from_email, message).deliver
    }

    respond_to do |format|
      format.html { redirect_to @post, notice: "We sent your message - thanks for sharing!" }
      format.js { flash.now[:notice] = "We sent your message - thanks for sharing!" }
    end

  end

  private
    def log_impression
      impressionist(@post) 
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_slug(params[:id]) || Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :slug, :user_id, :cover_photo_url)
    end
end
