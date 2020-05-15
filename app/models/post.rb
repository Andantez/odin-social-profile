# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope -> { order created_at: :desc }
  # Relationships
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :likers, through: :likes, source: :liker, dependent: :destroy

  # Validations
  validates :user, presence: true
end
