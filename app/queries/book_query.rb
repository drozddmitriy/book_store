class BookQuery
  DELIVERED = 3
  ITEM_LATEST_BOOKS = 3
  ITEM_BOOK_BEST_SELLERS = 4
  SORTS = {
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
    sql = "SELECT book_id AS book_id, COUNT(*) AS count_all FROM orders
           INNER JOIN order_items ON order_items.order_id = orders.id
           WHERE orders.status = #{DELIVERED}
           GROUP BY book_id
           ORDER BY count_all DESC"
    records_array = ActiveRecord::Base.connection.execute(sql).to_a
    book_id_keys = records_array.map { |h| h.values[0] }
    initial_scope.find(book_id_keys).first(ITEM_BOOK_BEST_SELLERS)
  end

  def by_filter(filter)
    return initial_scope.joins(:order_items).order(SORTS[filter]) if filter == :popular_first

    initial_scope.order(SORTS[filter])
  end
end
