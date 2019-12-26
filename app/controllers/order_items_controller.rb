class OrderItemsController < ApplicationController
  load_and_authorize_resource

  def index
    @items = current_order.order_items.includes(:book)
  end

  def create
    @order_item = OrderItem.find_or_initialize_by(book_id: params[:order_item][:book_id], order_id: current_order.id)
    @order_item.quantity = params[:order_item][:quantity]
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
    OrderItemService.change_quantity(@order_item, params[:quantity])
    @order_item.save

    redirect_back(fallback_location: root_path)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
