class Delivery < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, :time, :price, presence: true
end
