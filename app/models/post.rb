# frozen_string_literal: true

class Post < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Validations
  validates :user, presence: true
end
