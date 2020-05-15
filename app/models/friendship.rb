# frozen_string_literal: true

class Friendship < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  # Validations
  validates :user_id, :friend_id, presence: true

  # Return true if the  users are friends
  def self.exist?(user, friend)
    !find_by(user: user, friend: friend).nil?
  end

  # Record a pending friend request.

  def self.request(user, friend)
    unless (user == friend) || Friendship.exists?(user, friend)

      transaction do
        create(user: user, friend: friend, status: 'pending')

        create(user: friend, friend: user, status: 'requested')
      end

    end
  end

  # Accept friend request
  def self.accept(user, friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  # Delete a friendship request or cancel it
  def self.reject(user, friend)
    transaction do
      destroy(find_by(user: user, friend: friend))

      destroy(find_by(user: friend, friend: user))
    end
  end

  # Update the db with one side of the friend relationship
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by(user: user, friend: friend)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end
end
