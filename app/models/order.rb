class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  belongs_to :credit_card, optional: true
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_one :coupon, required: false, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  before_create :set_number

  enum status: %i[in_progress in_queue in_delivery delivered canceled]

  scope :all_orders, -> { order('created_at DESC') }

  aasm column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :place_in_queue do
      transitions from: %i[in_progress], to: %i[in_queue]
    end

    event :order_in_delivery do
      transitions from: %i[in_queue], to: %i[in_delivery]
    end

    event :order_delivered do
      transitions from: %i[in_delivery], to: %i[delivered]
    end

    event :canceled do
      transitions from: %i[in_queue in_delivery in_progress delivered], to: %i[canceled]
    end
  end

  # def set_status
  #   update(status: 1)
  # end

  def set_total_price
    update(total_price: total_order_price)
  end

  def set_order_use_billing(use_billing)
    if use_billing
      update(use_billing: true)
    else
      update(use_billing: false)
    end
  end

  def set_user_id(user_id)
    update(user_id: user_id)
  end

  def set_completed_at
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
