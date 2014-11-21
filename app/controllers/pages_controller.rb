class PagesController < ApplicationController

  def home
    @posts = Post.all
    render layout: false
  end

  def test 
    render layout: false
  end

  def about
  end

  def contact 
  end

  def photos
  end

end