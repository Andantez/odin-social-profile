# frozen_string_literal: true

# Check if the current_user have a relationship with the specific post
module UserHelper
  def liked?(post)
    current_user.liked_posts.include?(post)
  end
end
