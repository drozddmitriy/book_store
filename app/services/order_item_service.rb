class OrderItemService
  MINUS = 'minus'.freeze
  PLUS = 'plus'.freeze

  attr_reader :params, :current_order, :order_item

  def initialize(order_item_params, current_order, order_item = nil)
    @order_item = order_item
    @params = order_item_params
    @current_order = current_order
  end

  def change_quantity
    case params
    when PLUS
      order_item.quantity += 1
    when MINUS
      order_item.quantity -= 1 if order_item.quantity > 1
    end
    order_item
  end

  def create
    new_order_item = OrderItem.find_or_initialize_by(book_id: params[:book_id], order_id: current_order.id)
    new_order_item.quantity = params[:quantity]
    new_order_item
  end
end
