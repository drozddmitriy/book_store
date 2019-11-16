class OrderFiltersService
  class << self
    def filter(params, current_user)
      case params
      when 'in_queue' then current_user.orders.in_queue
      when 'in_delivery' then current_user.orders.in_delivery
      when 'delivered' then current_user.orders.delivered
      when 'canceled' then current_user.orders.canceled
      else current_user.orders.all_orders
      end
    end
  end
end
