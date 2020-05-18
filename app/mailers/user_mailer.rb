# frozen_string_literal: true

class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  default template_path: 'devise/mailer/welcome_email' # to make sure that your mailer uses the devise views
  # If there is an object in your application that returns a contact email, you can use it as follows
  # Note that Devise passes a Devise::Mailer object to your proc, hence the parameter throwaway (*)

  def welcome_email
    @user = params[:user]
    mail(to: @user.email,
         subject: "Welcome to Social Profile #{@user.username}")
  end
end
