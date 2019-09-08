class Book < ApplicationRecord
  FILTERS = %i[newest popular_first title_asc title_desc price_asc price_desc].freeze

  belongs_to :category
  has_many :authors_books
  has_many :authors, through: :authors_books

# Newest first, Popular first, Price: low to high, Price: high to low, Title: A - Z, Title: Z - A.

  scope :by_filter, ->(filter) { public_send(filter) }
  scope :newest, -> { order('created_at DESC') }
  scope :popular_first, -> { order('created_at DESC') }
  scope :title_asc, -> { order('title') }
  scope :title_desc, -> { order('title DESC') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price DESC') }
  scope :latest_books, -> { order('created_at DESC').limit(3) }
end
