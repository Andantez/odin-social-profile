# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  # find the user(current user) and find the friend(displayed user)
  def create
    Friendship.request(@user, @friend)
  end
end
