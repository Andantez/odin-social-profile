# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  # Create realtion between a user and a post
  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]
    @post = Post.find(params[:post_id])
    if @like.save
      flash[:notice] = 'Post liked'
      redirect_back(fallback_location: root_url)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to root_path
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    @post = Post.find(@like.post_id)
    flash[:alert] = 'Post disliked'
    redirect_back(fallback_location: root_url)
  end
end
