class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def invitation_email(user)
    @user = user
    @url = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to Billing System! Please Log In')
  end  
end
