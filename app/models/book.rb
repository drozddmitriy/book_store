class Book < ApplicationRecord
  FILTERS = %i[newest popular_first title_asc title_desc price_asc price_desc].freeze

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy

  mount_uploaders :images, ImageUploader

  def self.latest_books
    self.order('created_at DESC').limit(3)
  end

  def self.by_filter(filter)
    case filter
       when :newest then self.order('created_at DESC')
       when :popular_first then self.order('created_at DESC')
       when :title_asc then self.order('title')
       when :title_desc then self.order('title DESC')
       when :price_asc then self.order('price')
       when :price_desc then self.order('price DESC')
    end
  end
end
