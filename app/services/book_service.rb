class BookService
  def initialize(category_id, filter)
    @category_id = category_id
    @filter = filter
  end

  def call
    if @category_id
      Book.where(category_id: @category_id).by_filter(@filter)
    else
      Book.by_filter(@filter)
    end
  end
end
