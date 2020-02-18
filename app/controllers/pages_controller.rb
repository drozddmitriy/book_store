class PagesController < ApplicationController
  def home
    @latest_books = LatestBooksQuery.call.includes(:authors_books, :authors)
    @best_sellers = BestSellersQuery.call
  end
end
