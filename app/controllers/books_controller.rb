class BooksController < ApplicationController
  BOOKITEM = 8
  before_action :set_filter

  def index
    if params[:category]
      @category = Category.where(id: params[:category])
      @pagy, @books = pagy(Book.where(category_id: params[:category]).by_filter(@filter), items: BOOKITEM)
    else
      @pagy, @books = pagy(Book.by_filter(@filter), items: BOOKITEM)
      # @books = Book.by_filter(@filter).limit(8)
    end

    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors.map { |author| author.firstname + ' ' + author.lastname }.join(", ")
  end

  private
  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::FILTERS.first
  end
end
