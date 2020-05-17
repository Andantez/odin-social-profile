# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, foreign_key: :user_id, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :liked_post,
                         dependent: :destroy

  has_many :friendships
  # Preload friend list by status and sort them alphabetically
  has_many :friends, -> { where(friendships: { status: 'accepted' }).order(:username) },
           through: :friendships

  has_many :requested_friends, -> { where(friendships: { status: 'requested' }).order(created_at: :desc) },
           through: :friendships, source: :friend

  has_many :pending_friends, -> { where(friendships: { status: 'pending' }).order(created_at: :desc) },
           through: :friendships, source: :friend
  # Validations TODO more
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  def friends?(other_user)
    friendships.find_by(friend_id: other_user)
  end
end
