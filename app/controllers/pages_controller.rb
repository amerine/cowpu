class PagesController < ApplicationController
  def index
    @recent = Post.recent_posts
  end
end
