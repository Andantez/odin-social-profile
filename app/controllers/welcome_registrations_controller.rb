# frozen_string_literal: true

class WelcomeRegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      UserMailer.with(user: @user)
                .welcome_email.deliver_now
    end
  end
end
