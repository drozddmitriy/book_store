class OrdersController < ApplicationController
  load_and_authorize_resource

  ORDER_STATUSES = {
    in_queue: 'Waiting for processing',
    in_delivery: 'In delivery',
    delivered: 'Delivery',
    canceled: 'Canceled',
    all: 'All'
  }.freeze

  def index
    # order_status = params[:order_status]
    order_status = 'in_progress'
    binding.pry

    @orders = case order_status
              when 'in_queue' then current_user.orders.in_queue
              when 'in_delivery' then current_user.orders.in_delivery
              when 'delivered' then current_user.orders.delivered
              when 'canceled' then current_user.orders.canceled
              else current_user.orders.all_orders
              end

    @filter = order_status ? ORDER_STATUSES[order_status.to_sym] : 'All'
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    # binding.pry
  end
end
