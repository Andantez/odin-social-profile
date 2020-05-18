# Preview all emails at http://localhost:3000/rails/mailers/sign_up_mailer
class SignUpMailerPreview < ActionMailer::Preview
  def welcome_email
    SignUpMailer.welcome_email(User.first)
  end
end
