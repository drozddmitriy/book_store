class LatestBooksQuery
  ITEM_LATEST_BOOKS = 3

  class << self
    def call
      Book.order('created_at DESC').limit(ITEM_LATEST_BOOKS)
    end
  end
end
