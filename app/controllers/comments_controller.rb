# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post = post
  
    if comment.save
      flash[:notice] = 'Comment posted successfully'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Please write a comment, upload image or both"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:alert] = 'Comment deleted!'
    redirect_back(fallback_location: root_url)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end
end
