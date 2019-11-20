class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books
  validates :firstname, :lastname, presence: true
  validates :firstname, :lastname, length: { maximum: 50 }
end
