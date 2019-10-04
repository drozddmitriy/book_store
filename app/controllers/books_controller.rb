class BooksController < ApplicationController
  BOOKITEM = 8
  before_action :set_filter

  def index
    @pagy, @books = pagy(BookService.new(params[:category], @filter).call, items: BOOKITEM)
    @categories = Category.all
    @item = LineItem.new
  end

  def show
    @book = Book.find(params[:id])
    @item = LineItem.new
  end

  private

  def set_filter
    @filter = BookFiltersService.filter(params[:filter])
  end
end
