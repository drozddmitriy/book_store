class BooksController < ApplicationController
  load_and_authorize_resource

  ITEMS = 8
  SORTS = {
    newest: I18n.t('models.book.newest'),
    popular_first: I18n.t('models.book.popular_first'),
    title_asc: I18n.t('models.book.title_asc'),
    title_desc: I18n.t('models.book.title_desc'),
    price_asc: I18n.t('models.book.price_asc'),
    price_desc: I18n.t('models.book.price_desc')
  }.freeze

  before_action :set_filter

  def index
    @pagy, @books = pagy_countless(BookService.new(params[:category], @filter).call,
                                   items: ITEMS,
                                   link_extra: 'data-remote="true"')
    @categories = Category.all
    @category_title = BookService.new(params[:category]).category_title
    @item = LineItem.new
    @sort = params[:filter] ? SORTS[params[:filter].to_sym] : SORTS.first[1]
  end

  def show
    @book = Book.find(params[:id]).decorate
    @item = LineItem.new
  end

  private

  def set_filter
    @filter = BookFiltersService.filter(params[:filter])
  end
end
