class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, :card_number, :cvv, :expiration_month_year, presence: true
end
