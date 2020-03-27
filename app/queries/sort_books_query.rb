class SortBooksQuery < ApplicationQuery
  SORTS = {
    newest: 'created_at DESC',
    popular_first: 'count(order_items.id) DESC',
    title_asc: 'title',
    title_desc: 'title DESC',
    price_asc: 'price',
    price_desc: 'price DESC'
  }.freeze

  attr_accessor :initial_scope, :sort_params

  def initialize(initial_scope, sort_params)
    @initial_scope = initial_scope
    @sort_params = sort_params
  end

  def call
    return initial_scope.left_joins(:order_items).group(:id).order(SORTS[sort_params]) if sort_params == :popular_first

    initial_scope.order(SORTS[sort_params])
  end
end
