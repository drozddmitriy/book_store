class LineItemsController < ApplicationController
  load_and_authorize_resource

  def index
    @items = current_order.line_items.includes(:book)
  end

  def create
    @line_item = LineItem.find_or_initialize_by(book_id: params[:line_item][:book_id], order_id: current_order.id)
    @line_item.quantity = params[:line_item][:quantity]
    if @line_item.save
      flash[:success] = I18n.t('controllers.line_items.create')
    else
      flash[:danger] = I18n.t('controllers.line_items.not_create')
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @line_item.destroy
      flash[:success] = I18n.t('controllers.line_items.destroy')
    else
      flash[:danger] = I18n.t('controllers.line_items.not_destroy')
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    LineItemService.change_quantity(@line_item, params[:quantity])
    @line_item.save

    redirect_back(fallback_location: root_path)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end
end
