# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  # find the user(current user) and find the friend(displayed user)
  def create
    Friendship.request(current_user, User.find(params[:user]))
    flash[:notice] = 'Friend request sent.'
    redirect_back(fallback_location: root_url)
  end

  def accept
    @friend = User.find(params[:request_by_id])
    @user = current_user
    if @user.requested_friends.include?(@friend)
      Friendship.accept(current_user, User.find(params[:request_by_id]))
      flash[:notice] = "Friendship with #{@friend.username} accepted!"
      redirect_to friends_path
    else
      flash[:alert] = "No friend request from #{@friend.username}."
    end
  end

  def decline
    @friend = User.find(params[:request_by_id])
    @user = current_user
    if @user.requested_friends.include?(@friend)
      Friendship.reject(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.username} declined"
      redirect_to friends_path
    else
      flash[:alert] = "No friend request from #{@friend.username}."

    end
  end

  def cancel
    @friend = User.find(params[:pending_friend_id])
    @user = current_user
    if @user.pending_friends.include?(@friend)
      Friendship.reject(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.username} canceled"
      redirect_to friends_path
    else
      flash[:alert] = "No friend request with #{@friend.username}."

    end
  end

  def destroy
    @friend = User.find(params[:friend_id])
    @user = current_user
    if @user.friends.include?(@friend)
      Friendship.reject(@user, @friend)
      flash[:notice] = "#{@friend.username} was removed from your friendlist"
      redirect_to friends_path
    else
      flash[:alert] = "#{@friend.username} is not in your friendlist"
    end
  end
end
