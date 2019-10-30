class LineItemsController < ApplicationController
  load_and_authorize_resource

  def index
    @items = current_order.line_items
  end

  def create
    # binding.pry
    @line_item = LineItem.find_or_initialize_by(book_id: params[:line_item][:book_id], order_id: current_order.id)
    @line_item.quantity = params[:line_item][:quantity]
    if @line_item.save
      create_line_item
      flash[:success] = 'Item add to cart!'
    else
      flash[:danger] = 'Item not create!!!!!'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @line_item = LineItem.find_by(id: params[:id])

    if @line_item.destroy
      destroy_line_item
      flash[:success] = 'Item delete'
    else
      flash[:danger] = 'Item not delete'
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

  def line_item_ids
    session[:line_item_ids] ||= []
  end

  def create_line_item
    return if line_item_ids.include?(@line_item.id)
    line_item_ids << @line_item.id
  end

  def destroy_line_item
    line_item_ids.delete_if { |item_id| item_id == @line_item.id }
  end
end
