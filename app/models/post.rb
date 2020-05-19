# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope -> { order created_at: :desc }

  # Relationships
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :likers, through: :likes, source: :liker, dependent: :destroy
  has_one_attached :image

  # Validations TODO more
  validates :user, presence: true
  validates :image, content_type: { in: %w[image/jpeg],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
  validate :post_or_image

  private

  def post_or_image
    if content.blank? && image.blank?
      errors[:alert] << 'Comment, upload Image or Both'
    end
  end
end
