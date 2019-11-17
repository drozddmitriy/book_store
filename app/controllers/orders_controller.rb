class OrdersController < ApplicationController
  load_and_authorize_resource

  ORDER_STATUSES = {
    in_queue: I18n.t('controllers.orders.processing'),
    in_delivery: I18n.t('controllers.orders.in_delivery'),
    delivered: I18n.t('controllers.orders.delivered'),
    canceled: I18n.t('controllers.orders.canceled'),
    all: I18n.t('controllers.orders.all')
  }.freeze

  def index
    order_status = params[:order_status]
    @orders = OrderDecorator.decorate_collection(OrderFiltersService.filter(order_status, current_user))

    @filter = order_status ? ORDER_STATUSES[order_status.to_sym] : ORDER_STATUSES[:all]
  end

  def show
    @order = current_user.orders.find_by(id: params[:id]).decorate
    @current_address = OrderAddressesDecorator.decorate_collection(@order.addresses)
  end
end
