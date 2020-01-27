class Delivery < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :time, presence: true
  validates :name, uniqueness: true, length: { maximum: 50 }, presence: true
  validates :price, numericality: true, presence: true
end
