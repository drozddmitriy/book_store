class OrderItemsController < ApplicationController
  load_and_authorize_resource except: :index

  def index
    @items = current_order.order_items.includes(:book)
  end

  def create
    @order_item = OrderItemService.new(order_item_params, current_order).create
    if @order_item.save
      flash[:success] = I18n.t('controllers.order_items.create')
    else
      flash[:danger] = I18n.t('controllers.order_items.not_create')
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @order_item.destroy
      flash[:success] = I18n.t('controllers.order_items.destroy')
    else
      flash[:danger] = I18n.t('controllers.order_items.not_destroy')
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    @order_item = OrderItemService.new(params[:quantity], current_order, @order_item).change_quantity
    @order_item.save

    redirect_back(fallback_location: root_path)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
