# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = User.search_for_friends(params[:query])
  end

  def show
    @user = User.includes(:friendships, posts: [:comments]).find(params[:id])
    @comment = Comment.new
  end
end
