class PostsController < ApplicationController

  def new
    @post = Post.new
    authorize @post
    Rails.logger.debug("new post: #{@post.inspect}")

  end

  def create
    @post = Post.create(post_params)
    authorize @post
    @post.user = current_user

    if params[:status] == "preview"
      if @post.save
        redirect_to blog_preview_path(@post)
        Rails.logger.debug("Preview post: #{@post.inspect}")
      else
        flash[:error] = "Error: Could not produce preview. Please check your form"
        render :new
      end
    elsif params[:status] == "draft"
      save_post("saved to drafts")
    elsif params[:status] == "published"
      save_post("published")
    end
  end

  def edit
    @post = Post.find_from_slug(params[:id])
    authorize @post
  end

  def update
    @post = Post.find_from_slug(params[:id])
    authorize @post

    if @post.update_attributes(post_params)
      redirect_to @post
      flash[:notice] = "Your blog post has successfully been updated"
    else
      render :edit
      flash[:error] = "Something went wrong and your post was not updated"
    end
  end

  def show
    @post = Post.find_from_slug(params[:id])
    @allowed_labels = ["preview", "draft", "published"]
  end

  def index
    @posts = policy_scope(Post).paginate(page: params[:page], per_page: 10)
    authorize @posts
    @allowed_labels = ["draft", "published"]
  end

  def destroy
    @post = Post.find_from_slug(params[:id])
    authorize @post
    @post.status = "deleted"
    if @post.save
      flash[:notice] = "Your post is now invisible and will be automatically deleted in 5 days."
      redirect_to blog_posts_path
    else
      flash[:error] = "There was a problem deleting your post. Please notify an engineer"
    end
  end

  def preview
    @post = Post.find_from_slug(params[:id])
    authorize @post
    @allowed_labels = ["preview"]
  end

  #helpers

  def post_params
    params[:post][:status] = params[:status] if params[:status]
    params.require(:post).permit(:content, :title, :status)
  end

  def save_post(verb)
    if @post.save
      redirect_to blog_posts_path
      flash[:notice] = "#{current_user.first_name}, your blog post has successfully been #{verb}"
    else
      render :new
      flash[:error] = "Something went wrong and your post has not been published"
    end
  end
end
