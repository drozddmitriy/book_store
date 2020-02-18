class BookService
  attr_reader :category_id, :filter

  def initialize(category_id, filter = nil)
    @category_id = category_id
    @filter = filter
  end

  def filter_for_books
    return SortBooksQuery.new(Book.all).by_sort(filter).includes(:authors_books, :authors) unless category_id

    SortBooksQuery.new(Book.where(category_id: category_id)).by_sort(filter).includes(:authors_books, :authors)
  end

  def category_title
    Category.where(id: category_id).first.title if category_id
  end
end
