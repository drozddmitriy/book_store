class BookService
  attr_reader :category_id, :filter

  def initialize(category_id, filter = nil)
    @category_id = category_id
    @filter = filter
  end

  def sort_for_books
    return SortBooksQuery.call(Book.all, filter).includes(:authors) unless category_id

    SortBooksQuery.call(Book.where(category_id: category_id), filter).includes(:authors)
  end

  def category_title
    Category.where(id: category_id).first.title if category_id
  end
end
