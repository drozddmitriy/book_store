class OrderMailer < ApplicationMailer
  default from: 'from@example.com'

  def confirm_order(user)
    @user = user
    mail(to: user.email, subject: 'Your Order with bookstore.com')
  end
end
