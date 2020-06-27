class UserMailer < ApplicationMailer
  def welcome_send user
    @user = user
    mail to: user.email, subject: "Welcome", from: "LinhShop@gmail.com"
  end
end