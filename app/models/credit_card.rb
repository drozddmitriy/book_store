class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, format: { with: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/ }
  validates :expiration_month_year, format: { with: %r{\A((0[1-9])|(1[0-2]))[/]*((1[5-9])|(2[0-3]))\Z} }
  validates :name, :card_number, :cvv, :expiration_month_year, presence: true
  validates :card_number, :cvv, numericality: { only_integer: true }
  validates :card_number, length: { is: 16 }
  validates :name, length: { maximum: 50 }
  validates :cvv, format: { with: /\A[0-9]{3,4}\Z/ }
end
