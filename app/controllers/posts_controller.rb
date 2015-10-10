class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save
      redirect_to blog_posts_path
      flash[:notice] = "#{current_user.first_name}, your blog post has successfully been published"
    else
      render :new
      flash[:error] = "Something went wrong and your post has not been published"
    end
  end

  def edit
    @post = Post.find_from_slug(params[:id])
  end

  def update
    @post = Post.find_from_slug(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post
      flash[:notice] = "#{current_user.first_name}, your blog post has successfully been updated"
    else
      render :edit
      flash[:error] = "Something went wrong and your post was not updated"
    end
  end

  def show
    @post = Post.find_from_slug(params[:id])
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @post = Post.find_from_slug(params[:id])
    if @post.destroy
      flash[:notice] = "Your post has been successfully deleted"
      redirect_to @post
    else
      flash[:error] = "There was a problem deleting your post. Please notify an engineer"
    end
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
end
