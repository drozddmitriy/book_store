class BestSellersQuery < ApplicationQuery
  DELIVERED = 3

  class << self
    def call
      ids = OrderItem.left_joins(:order, :book)
                     .select('DISTINCT ON (books.category_id) books.id, SUM(order_items.quantity) as total_quantity')
                     .where('orders.status = ?', DELIVERED)
                     .group('books.id')
                     .order('books.category_id, total_quantity DESC')

      Book.where(id: ids.map(&:id))
    end
  end
end
