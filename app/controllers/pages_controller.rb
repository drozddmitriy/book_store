class PagesController < ApplicationController
  authorize_resource class: false

  def home
    @latest_books = BookQuery.new(Book.all).latest_books.includes(:authors_books, :authors)
    @best_sellers = BookQuery.new(Book.all).best_sellers
  end
end
