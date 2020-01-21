class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    order_object = OrderFiltersService.new(params[:order_status], current_user)
    @orders = OrderDecorator.decorate_collection(order_object.filter.includes(:order_items))

    @filter = order_object.filter_menu
  end

  def show
    @order = @order.decorate
    @current_address = OrderAddressesDecorator.decorate_collection(@order.addresses)
  end
end
