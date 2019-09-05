class Book < ApplicationRecord
  belongs_to :category
  has_many :authors_books
  has_many :authors, through: :authors_books
end
