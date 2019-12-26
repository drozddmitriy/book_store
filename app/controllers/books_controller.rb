class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :book_filter

  def index
    @pagy, @books = pagy_countless(BookService.new(params[:category], @filter).filter_for_books,
                                   items: Book::ITEMS,
                                   link_extra: 'data-remote="true"')
    @categories = Category.all
    @category_title = BookService.new(params[:category]).category_title
    @item = OrderItem.new
    @sort = BookFiltersService.new(params[:filter]).filter_string
  end

  def show
    @book = Book.find(params[:id]).decorate
    @item = OrderItem.new
  end

  private

  def book_filter
    @filter = BookFiltersService.new(params[:filter]).filter_sym
  end
end
