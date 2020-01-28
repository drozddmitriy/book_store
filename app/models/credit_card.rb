class CreditCard < ApplicationRecord
  NAME_REG_EXP = /\A[a-zA-Z]*\s*[a-zA-Z]*\z/.freeze
  EXP_MONTH_YEAR_REG_EXP = %r{\A((0[1-9])|(1[0-2]))[/]*((1[5-9])|(2[0-3]))\Z}.freeze
  CVV_REG_EXP = /\A[0-9]{3,4}\Z/.freeze

  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, format: NAME_REG_EXP
  validates :name, presence: true, length: { maximum: 50 }

  validates :expiration_month_year, format: EXP_MONTH_YEAR_REG_EXP, presence: true

  validates :card_number, presence: true, length: { is: 16 }
  validates :card_number, numericality: { only_integer: true }

  validates :cvv, format: CVV_REG_EXP, numericality: { only_integer: true }, presence: true
end
