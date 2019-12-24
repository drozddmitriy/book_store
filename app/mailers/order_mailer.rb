class OrderMailer < ApplicationMailer
  default from: ENV['EXAMPLE_MAIL']

  def confirm_order(user)
    @user = user
    mail(to: user.email, subject: I18n.t('order_mailer.message'))
  end
end
