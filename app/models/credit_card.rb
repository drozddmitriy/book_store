class CreditCard < ApplicationRecord
  REGULAR_EXP = {
    name: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/,
    exp_month_year: %r{\A((0[1-9])|(1[0-2]))[/]*((1[5-9])|(2[0-3]))\Z},
    cvv: /\A[0-9]{3,4}\Z/
  }.freeze

  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, format: REGULAR_EXP[:name]
  validates :name, presence: true, length: { maximum: 50 }

  validates :expiration_month_year, format: REGULAR_EXP[:exp_month_year], presence: true

  validates :card_number, presence: true, length: { is: 16 }
  validates :card_number, numericality: { only_integer: true }

  validates :cvv, format: REGULAR_EXP[:cvv], numericality: { only_integer: true }, presence: true
end
