class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, :card_number, :cvv, :expiration_month_year, presence: true
  validates :card_number, :cvv, numericality: { only_integer: true }
  validates :card_number, length: { is: 16 }
  validates :name, length: { maximum: 50 }
  validates :cvv, length: 3..4
end
