class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :sale, presence: true
  validates :coupon, presence: true, uniqueness: true, length: { is: 10 }
end
