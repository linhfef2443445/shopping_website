class OrderMailer < ApplicationMailer
  def order_mail(order, user)
    @order = order
    @user = user
    mail to: @user.email, subject: "Payment successful", from: "LinhShop@gmail.com"
  end
end
