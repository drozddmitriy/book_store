class BookDecorator < Draper::Decorator
  delegate_all
  decorates_association :authors

  def author_full_name
    authors.map(&:full_name).join(', ')
  end

  def book_dimensions
    I18n.t('decorator.dimension', dimension_h: dimension_h, dimension_w: dimension_w, dimension_d: dimension_d)
  end

  def book_reviews
    reviews.where(publish: true).count
  end
end
