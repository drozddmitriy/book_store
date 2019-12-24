class BookQuery
  ITEM_LATEST_BOOKS = 3
  ITEM_BOOK_BEST_SELLERS = 4
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def latest_books
    initial_scope.order('created_at DESC').limit(ITEM_LATEST_BOOKS)
  end

  def best_sellers
    initial_scope.find(Order.joins(:line_items).group(:book_id).canceled.count.keys).first(ITEM_BOOK_BEST_SELLERS)
  end

  def by_filter(filter)
    case filter
    when :newest then initial_scope.order('created_at DESC')
    when :popular_first then initial_scope.joins(:line_items).order('line_items.quantity DESC')
    when :title_asc then initial_scope.order('title')
    when :title_desc then initial_scope.order('title DESC')
    when :price_asc then initial_scope.order('price')
    when :price_desc then initial_scope.order('price DESC')
    end
  end
end
