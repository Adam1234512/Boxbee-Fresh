class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params.require(:post).permit(:content))
    @post.save
  end

  def edit
  end

  def index
    @posts = Post.all
  end
end
