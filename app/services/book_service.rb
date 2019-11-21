class BookService
  def initialize(category_id, filter = nil)
    @category_id = category_id
    @filter = filter
  end

  def call
    if @category_id
      Book.where(category_id: @category_id).by_filter(@filter).includes(:authors_books, :authors)
    else
      Book.by_filter(@filter).includes(:authors_books, :authors)
    end
  end

  def category_title
    Category.where(id: @category_id).first.title if @category_id
  end
end
