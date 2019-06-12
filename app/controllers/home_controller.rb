class HomeController < ApplicationController
  def index
    @posts = Post.all.order(:updated_at)
    @posts = Post.all
    @users = User.all
  end
end
