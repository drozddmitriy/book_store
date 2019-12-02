class LineItemsController < ApplicationController
  load_and_authorize_resource

  def index
    @items = current_order.line_items.includes(:book)
  end

  def create
    @line_item = LineItem.find_or_initialize_by(book_id: params[:line_item][:book_id], order_id: current_order.id)
    @line_item.quantity = params[:line_item][:quantity]
    if @line_item.save
      flash[:success] = 'Item add to cart!'
    else
      flash[:danger] = 'Item not create!'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @line_item = LineItem.find_by(id: params[:id])

    if @line_item.destroy
      flash[:success] = 'Item delete!'
    else
      flash[:danger] = 'Item not delete!'
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    @line_item = LineItem.find_by(id: params[:id])
    case params[:quantity]
    when 'plus'
      @line_item.quantity += 1
    when 'minus'
      @line_item.quantity -= 1 if @line_item.quantity > 1
    end

    @line_item.save

    redirect_back(fallback_location: root_path)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end
end
