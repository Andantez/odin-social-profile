# frozen_string_literal: true

class Comment < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :post

  # Validations TODO more
  validates :user, :post, presence: true
  validates :content, presence: true
end
