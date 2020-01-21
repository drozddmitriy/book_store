class ReviewDecorator < Draper::Decorator
  delegate_all

  def logo
    user.email.chars.first
  end
end
