class BookService
  attr_reader :category_id, :filter

  def initialize(category_id, filter = nil)
    @category_id = category_id
    @filter = filter
  end

  def filter_for_books
    return BookQuery.new(Book.all).by_filter(filter).includes(:authors_books, :authors) unless category_id

    BookQuery.new(Book.where(category_id: category_id)).by_filter(filter).includes(:authors_books, :authors)
  end

  def category_title
    Category.where(id: category_id).first.title if category_id
  end
end
