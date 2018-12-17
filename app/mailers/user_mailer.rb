class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://friend-space.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Z Dates')
  end
end
