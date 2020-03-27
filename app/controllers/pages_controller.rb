class PagesController < ApplicationController
  def home
    @latest_books = LatestBooksQuery.call.includes(:authors)
    @best_sellers = BestSellersQuery.call.includes(:authors)
  end
end
