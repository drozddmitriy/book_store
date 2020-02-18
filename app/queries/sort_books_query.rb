class SortBooksQuery
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

  def by_sort(filter)
    return initial_scope.left_joins(:order_items).group(:id).order(SORTS[filter]) if filter == :popular_first

    initial_scope.order(SORTS[filter])
  end
end
