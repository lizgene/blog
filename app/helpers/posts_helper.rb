module PostsHelper
  require 'uri'

  def html_safe_url post
    return URI.escape(post_url(post))
  end

  def facebook_share_url post
    return "http://www.facebook.com/sharer.php?s=100&p[url]=#{html_safe_url(post)}"
  end

  def twitter_share_url post
    text = URI.escape("Awesome article - worth a read!")

    return "https://twitter.com/intent/tweet?text=#{text}&url=#{html_safe_url(post)}&via=lizhubertz"
  end
end