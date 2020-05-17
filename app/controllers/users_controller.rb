# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.includes(:friendships, posts: [:comments]).find(params[:id])
  end
end
