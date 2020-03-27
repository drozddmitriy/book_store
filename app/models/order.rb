class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  belongs_to :credit_card, optional: true
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, required: false, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  before_create :set_number

  enum status: { in_progress: 0, in_queue: 1, in_delivery: 2, delivered: 3, canceled: 4 }

  scope :all_orders, -> { where.not(status: :in_progress).order('created_at DESC') }

  aasm column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :order_in_queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :order_in_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :order_delivered do
      transitions from: :in_delivery, to: :delivered
    end

    event :canceled do
      transitions from: %i[in_progress in_queue in_delivery delivered], to: :canceled
    end
  end

  def update_total_price(total_order_price)
    update(total_price: total_order_price)
  end

  def order_use_billing(use_billing)
    use_billing ? update(use_billing: true) : update(use_billing: false)
  end

  def user_id(user_id)
    update(user_id: user_id)
  end

  def set_completed_at
    update(completed_at: Time.current)
  end

  private

  def set_number
    self.number ||= 'R' + Array.new(10) { rand(1...10) }.join
  end
end
