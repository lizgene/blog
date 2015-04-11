class AdminController < ApplicationController
  before_action :authenticate_user!

  # GET /admin/stats
  def stats
    @posts = Post.top(5)
    @albums = Album.top(5)
  end

end
