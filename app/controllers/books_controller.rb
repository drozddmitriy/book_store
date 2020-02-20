class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :book_sort

  # rubocop:disable Metrics/AbcSize
  def index
    @pagy, @books = pagy_countless(BookService.new(params[:category], @sorts).sort_for_books,
                                   items: Book::ITEMS,
                                   link_extra: 'data-remote="true"')
    @categories = Category.all
    @category_title = BookService.new(params[:category]).category_title
    @sort = BookSortService.new(params[:sort]).sort_string
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @book = @book.decorate
    @item = OrderItem.new
  end

  private

  def book_sort
    @sorts = BookSortService.new(params[:sort]).sort_sym
  end
end
