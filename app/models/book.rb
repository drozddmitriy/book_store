class Book < ApplicationRecord
  ITEMS = 8

  validates :title, :price, :quantity, :dimension_h, :dimension_w, :dimension_d, presence: true
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }
  validates :description, length: { maximum: 2000 }
  validates :price, numericality: { only_integer: true }, length: { maximum: 7 }

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy

  mount_uploaders :images, ImageUploader
end
