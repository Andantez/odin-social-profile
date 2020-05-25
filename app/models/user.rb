# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for_friends,
                  against: %i[first_name last_name username],
                  using: {
                    tsearch: { prefix: true }
                  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
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
  has_one_attached :avatar
  # Validations TODO more
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :avatar, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: 'must be a valid image format' },
                     size: { less_than: 5.megabytes,
                             message: 'should be less than 5MB' }

  def friends?(other_user)
    friendships.find_by(friend_id: other_user)
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice('provider', 'uid')
    user_params.merge! auth.info.slice('email', 'first_name', 'last_name')
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params[:username] = auth.info.first_name
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20] # Fake password for validation
      user.username = auth.info.name.split.first
      user.save
    end
    user
  end
end
