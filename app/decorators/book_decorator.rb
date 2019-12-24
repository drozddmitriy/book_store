class BookDecorator < Draper::Decorator
  delegate_all

  def author_full_name
    authors.map { |author| author.first_name + ' ' + author.last_name }.join(', ')
  end

  def book_dimensions
    "H: #{dimension_h} x W: #{dimension_w} x D: #{dimension_d}"
  end

  def book_reviews
    reviews.where(publish: true).count
  end
end
