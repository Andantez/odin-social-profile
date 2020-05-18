# frozen_string_literal: true

class SignUpMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email,
         subject: "Welcome to Social Profile #{@user.username}")
  end
end
