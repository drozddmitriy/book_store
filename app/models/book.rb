class Book < ApplicationRecord
  ITEMS = 8

  validates :title, presence: true
  validates :quantity, presence: true
  validates :dimension_h, presence: true
  validates :dimension_w, presence: true
  validates :dimension_d, presence: true
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }
  validates :description, length: { maximum: 2000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }, length: { maximum: 7 }

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy

  mount_uploaders :images, ImageUploader
end
