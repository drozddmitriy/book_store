class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { maximum: 50 }
end
