class LatestBooksQuery < ApplicationQuery
  ITEM_LATEST_BOOKS = 3

  def call
    Book.order('created_at DESC').limit(ITEM_LATEST_BOOKS)
  end
end
