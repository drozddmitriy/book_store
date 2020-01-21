class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :book_filter

  # rubocop:disable Metrics/AbcSize
  def index
    @pagy, @books = pagy_countless(BookService.new(params[:category], @filter).filter_for_books,
                                   items: Book::ITEMS,
                                   link_extra: 'data-remote="true"')
    @categories = Category.all
    @category_title = BookService.new(params[:category]).category_title
    @sort = BookFiltersService.new(params[:filter]).filter_string
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @book = @book.decorate
    @item = OrderItem.new
  end

  private

  def book_filter
    @filter = BookFiltersService.new(params[:filter]).filter_sym
  end
end
