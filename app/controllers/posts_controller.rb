# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: %i[edit update destroy]

  def index
    # Get the friend ids of the current_user and display the friends posts
    ids = current_user.friends.pluck(:id) << current_user.id
    @posts = Post.where(user_id: ids).includes(image_attachment: [:blob],
                                               user: %i[posts comments friendships],
                                               comments: [:user, image_attachment: [:blob]])
    @comment = Comment.new
  end

  # def show
  #   @comment = Comment.new
  # end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post created'
      redirect_to root_url
    else
      flash.now[:alert] = 'Something went wrong, please try again'
      render :new
    end
  end

  def edit; end

  def update
    return unless @post.update(post_params)

    flash[:notice] = 'Post updated'
    redirect_to @post
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post deleted'
    redirect_back(fallback_location: root_url)
  end

  private

  def set_params
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
