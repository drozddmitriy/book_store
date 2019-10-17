class BookDecorator < Draper::Decorator
  delegate_all

  def author_full_name
    authors.map { |author| author.firstname + ' ' + author.lastname }.join(", ")
  end

  def book_dimensions
    "H: #{dimension_h} x W: #{dimension_w} x D: #{dimension_d}"
  end
end
