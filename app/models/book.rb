class Book < ApplicationRecord
  ITEM_LATEST_BOOKS = 3
  ITEM_BOOK_BEST_SELLERS = 4
  FILTERS = %i[newest popular_first title_asc title_desc price_asc price_desc].freeze

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy

  mount_uploaders :images, ImageUploader

  def self.latest_books
    self.order('created_at DESC').limit(ITEM_LATEST_BOOKS)
  end

  def self.best_sellers
    # SELECT COUNT(*) AS count_all, "book_id" AS book_id FROM "orders" INNER JOIN "line_items" ON "line_items"."order_id" = "orders"."id" WHERE (orders.status = 4) GROUP BY "book_id"
    # binding.pry
    self.find(Order.joins(:line_items).group(:book_id)
                    .where("orders.status = ?", 4).count.keys).first(ITEM_BOOK_BEST_SELLERS)
  end

  def self.by_filter(filter)
    case filter
       when :newest then self.order('created_at DESC')
       when :popular_first then self.joins(:line_items).order('line_items.quantity DESC')
       when :title_asc then self.order('title')
       when :title_desc then self.order('title DESC')
       when :price_asc then self.order('price')
       when :price_desc then self.order('price DESC')
    end
  end
end
