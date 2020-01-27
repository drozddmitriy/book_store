class Address < ApplicationRecord
  REGULAR_EXP = {
    name: /\A[a-zA-Z]*\z/,
    address: /\A[a-zA-Z0-9 \-\,]*\z/,
    zip: /\A[0-9\-]*\z/,
    phone: /\A\+[0-9]*\z/
  }.freeze

  belongs_to :addressable, polymorphic: true
  enum cast: { shipping: 0, billing: 1 }

  validates :cast, presence: true

  validates :phone, format: { with: REGULAR_EXP[:phone] }, length: { maximum: 15 }, presence: true

  validates :first_name, format: { with: REGULAR_EXP[:name] }, length: { maximum: 50 }, presence: true

  validates :address, format: { with: REGULAR_EXP[:address] }, length: { maximum: 50 }, presence: true

  validates :zip, format: { with: REGULAR_EXP[:zip] }, length: { maximum: 10 }, presence: true

  validates :last_name, format: { with: REGULAR_EXP[:name] }, length: { maximum: 50 }, presence: true

  validates :city, format: { with: REGULAR_EXP[:name] }, length: { maximum: 50 }, presence: true

  validates :country, format: { with: /\A[a-zA-Z]*\z/ }, length: { maximum: 50 }, presence: true
end
