class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    order_status = params[:order_status]
    @orders = OrderDecorator.decorate_collection(OrderFiltersService.new(order_status, current_user)
                                                                    .filter.includes(:order_items))

    @filter = (OrderFiltersService::FILTERS.include?(order_status&.to_sym) ?
    OrderFiltersService::FILTERS[order_status.to_sym] : OrderFiltersService::FILTERS[:all]).call
  end

  def show
    @order = @order.decorate
    @current_address = OrderAddressesDecorator.decorate_collection(@order.addresses)
  end
end
