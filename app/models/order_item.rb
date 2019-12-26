class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order, optional: true

  validates :quantity, presence: true

  def total_price
    book.price * quantity
  end
end
