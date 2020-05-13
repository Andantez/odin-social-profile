# frozen_string_literal: true

class Like < ApplicationRecord
  # Relationships
  belongs_to :liker, class_name: 'User', foreign_key: :user_id
  belongs_to :liked_post, class_name: 'Post', foreign_key: :post_id

  # Validations
end
