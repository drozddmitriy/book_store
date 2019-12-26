class OrderMailer < ApplicationMailer
  default from: 'from@example.com'

  def confirm_order(user)
    @user = user
    mail(to: user.email, subject: I18n.t('order_mailer.message'))
  end
end
