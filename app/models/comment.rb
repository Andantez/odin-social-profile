# frozen_string_literal: true

class Comment < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :post
  has_one_attached :image

  # Validations TODO more
  validates :user, :post, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
  validate :comment_or_image

  private

  def comment_or_image
    if content.blank? && image.blank?
      errors[:alert] << 'Comment, upload Image or Both'
    end
  end
end
