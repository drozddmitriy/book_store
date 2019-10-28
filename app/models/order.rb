class Order < ApplicationRecord
  belongs_to :credit_card, optional: true
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_one :coupon, required: false, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  before_create :set_number

  def check_status
    update(status: 1)
  end

  def check_total_price
    update(total_price: total_order_price)
  end

  def check_completed_at
    update(completed_at: Time.current)
  end

  def total_price
    line_items.map { |item| item.book.price * item.quantity }.sum
  end

  def discount
    return 0 unless coupon

    total_price * coupon.sale / 100
  end

  def total_order_price
    return total_price unless coupon

    total_price - discount
  end

  private

  def set_number
    self.number ||= generate_number
    self.status = 0
  end

  def generate_number
    characters = %w(A B C D E F G H J K L M P Q R T W X Y Z 1 2 3 4 5 6 7 8 9)
    code = ''

    6.times { code << characters.sample }

    code
  end
end
