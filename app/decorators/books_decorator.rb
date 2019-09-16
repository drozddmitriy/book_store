class BooksDecorator
  def initialize(category_id)
    @category_id = category_id
  end

  def category_title
    Category.where(id: @category_id).first.title
  end
end
