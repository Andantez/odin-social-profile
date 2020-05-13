# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  # Create realtion between a user and a post
  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]
    if @like.save
      flash[:notice] = 'Post liked'
      redirect_to root_url
    else
      flash[:alert] = 'ERROR'
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    flash[:alert] = 'Post disliked'
    redirect_to root_url
  end
end
