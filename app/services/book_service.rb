class BookService
  attr_reader :category_id, :sort_params

  def initialize(category_id, sort_params = nil)
    @category_id = category_id
    @sort_params = sort_params
  end

  def sort_for_books
    return SortBooksQuery.call(Book.all, sort_params).includes(:authors) unless category_id

    SortBooksQuery.call(Book.where(category_id: category_id), sort_params).includes(:authors)
  end

  def category_title
    Category.where(id: category_id).first.title if category_id
  end
end
