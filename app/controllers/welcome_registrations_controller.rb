# frozen_string_literal: true

class WelcomeRegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      SignUpMailer.with(user: @user)
                  .welcome_email.deliver_later
    end
  end
end
