class AuthorDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{author.first_name} #{author.last_name}"
  end
end
