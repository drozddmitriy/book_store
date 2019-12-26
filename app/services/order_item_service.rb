class OrderItemService
  MINUS = 'minus'.freeze
  PLUS = 'plus'.freeze

  class << self
    def change_quantity(order_item, params)
      case params
      when PLUS
        order_item.quantity += 1
      when MINUS
        order_item.quantity -= 1 if order_item.quantity > 1
      end
    end
  end
end
