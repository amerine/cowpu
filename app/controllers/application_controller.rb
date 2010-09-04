class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_recent
  
  def get_recent
    @recent = Post.recent_posts
  end
end
