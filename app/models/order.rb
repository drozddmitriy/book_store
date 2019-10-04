class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_one :coupon, dependent: :destroy

  before_create :set_cupon_number

  def total_price
    line_items.map { |item| item.book.price * item.quantity }.sum
  end

  private

  def set_cupon_number
    self.number ||= generate_coupon_code
  end

  def generate_coupon_code
    characters = %w(A B C D E F G H J K L M P Q R T W X Y Z 1 2 3 4 5 6 7 8 9)
    code = ''

    6.times { code << characters.sample }

    code
  end
end
