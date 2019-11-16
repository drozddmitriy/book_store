class ReviewDecorator < Draper::Decorator
  delegate_all

  def date
    created_at.strftime("%d/%m/%y")
  end

  def logo
    user.email.chars.first
  end
end
