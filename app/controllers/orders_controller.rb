class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    order_status = params[:order_status]
    @orders = OrderDecorator.decorate_collection(OrderFiltersService.new(order_status, current_user)
                                                                    .filter.includes(:order_items))

    @filter = order_status ? OrderFiltersService::FILTERS[order_status.to_sym] : OrderFiltersService::FILTERS[:all]
  end

  def show
    @order = current_user.orders.find_by(id: params[:id]).decorate
    @current_address = OrderAddressesDecorator.decorate_collection(@order.addresses)
  end
end
