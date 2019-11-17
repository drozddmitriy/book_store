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
    order_status = params[:order_status]
    @orders = OrderDecorator.decorate_collection(OrderFiltersService.filter(order_status, current_user))

    @filter = order_status ? ORDER_STATUSES[order_status.to_sym] : ORDER_STATUSES[:all]
  end

  def show
    @order = current_user.orders.find_by(id: params[:id]).decorate
  end
end
