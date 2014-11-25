class PagesController < ApplicationController

  def home
    @posts = Post.all
    render layout: false
  end

  def test 
  end

  def about
  end

  def contact 
  end

  def photos
    client = Picasa::Client.new(user_id: current_user.email, authorization_header: "Bearer #{current_user.single_access_token}")
    album = client.album.show(5599961089581972241)
    @photos = album.photos


    #FULL API CALL
    #https://picasaweb.google.com/data/feed/api/user/115535394189737416364/albumid/5599961089581972241/photoid/5599961085719892146?alt=json&authkey=Gv1sRgCJnlz5KV75jipgE
    #@thumbnails = @photo.media # just to show thumbnails
    #<Picasa::Presenter::Media thumbnails: [#<Picasa::Presenter::Thumbnail url: "https://lh4.googleusercontent.com/-lVFgTwo_lK8/TbcO8AZYULI/AAAAAAAAACg/h7X-82TIv5Y/s72/time4tickles.jpg", width: 72, height: 54>, #<Picasa::Presenter::Thumbnail url: "https://lh4.googleusercontent.com/-lVFgTwo_lK8/TbcO8AZYULI/AAAAAAAAACg/h7X-82TIv5Y/s144/time4tickles.jpg", width: 144, height: 108>, #<Picasa::Presenter::Thumbnail url: "https://lh4.googleusercontent.com/-lVFgTwo_lK8/TbcO8AZYULI/AAAAAAAAACg/h7X-82TIv5Y/s288/time4tickles.jpg", width: 288, height: 216>], credit: "Liz Hubertz", description: "", keywords: nil, title: "time4tickles.jpg">
    
    #@url = @photo.content #ACTUAL URL
    #<Picasa::Presenter::Content type: "image/jpeg", src: "https://lh4.googleusercontent.com/-lVFgTwo_lK8/TbcO8AZYULI/AAAAAAAAACg/h7X-82TIv5Y/time4tickles.jpg">
  end

end