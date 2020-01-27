class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :sale, presence: true
  validates :coupon, presence: false, uniqueness: true, length: { is: 10 }, allow_blank: true
  validates :active, presence: false
end
