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

  # Validations
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  
end
