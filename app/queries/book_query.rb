class BookQuery
  DELIVERED = 3
  ITEM_LATEST_BOOKS = 3
  SORTS = {
    newest: 'created_at DESC',
    popular_first: 'count(order_items.id) DESC',
    title_asc: 'title',
    title_desc: 'title DESC',
    price_asc: 'price',
    price_desc: 'price DESC'
  }.freeze

  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def latest_books
    initial_scope.order('created_at DESC').limit(ITEM_LATEST_BOOKS)
  end

  def best_sellers
    ids = OrderItem.joins(:order, :book).select('book_id as book_id')
                   .where('orders.status = ?', DELIVERED).group(:book_id, :category_id)

    initial_scope.where(id: ids)
  end

  def by_sort(filter)
    return initial_scope.joins(:order_items).group(:id).order(SORTS[filter]) if filter == :popular_first

    initial_scope.order(SORTS[filter])
  end
end
