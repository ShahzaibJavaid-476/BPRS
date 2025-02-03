class UserMailer < ApplicationMailer
    default from: 'no-reply@billing_system.com'  
    def invitation_email(user)
      @user = user
      @url = new_user_session_url
      mail(to: @user.email, subject: 'Welcome to Billing System! Please Log In to')
    end
end
  