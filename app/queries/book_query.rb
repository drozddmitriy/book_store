class BookQuery
  ITEM_LATEST_BOOKS = 3
  ITEM_BOOK_BEST_SELLERS = 4
  FILTER = {
    newest: 'created_at DESC',
    popular_first: 'order_items.quantity DESC',
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
    initial_scope.find(Order.joins(:order_items).group(:book_id).canceled.count.keys).first(ITEM_BOOK_BEST_SELLERS)
  end

  def by_filter(filter)
    return initial_scope.joins(:order_items).order(FILTER[filter]) if filter == :popular_first

    initial_scope.order(FILTER[filter])
  end
end
