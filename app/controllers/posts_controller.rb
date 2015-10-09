class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params.require(:post).permit(:content, :title))
    @post.save
    Rails.logger.debug("ID of @post is: #{@post.id}")
    redirect_to action: 'show', id: "#{@post.title.to_url}"
  end

  def edit
  end

  def show
    @post = Post.find_from_slug(params[:id])
  end

  def index
    @posts = Post.all
  end
end
