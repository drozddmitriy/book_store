class PagesController < ApplicationController
  authorize_resource class: false

  def home
    @latest_books = Book.latest_books.includes(:authors)
    @best_sellers = Book.best_sellers
  end
end
