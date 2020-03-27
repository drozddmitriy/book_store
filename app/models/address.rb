class Address < ApplicationRecord
  PHONE_REG_EXP = /\A\+[0-9]*\z/.freeze
  ZIP_REG_EXP = /\A[0-9\-]*\z/.freeze
  ADDRESS_REG_EXP = /\A[a-zA-Z0-9 \-\,]*\z/.freeze
  NAME_REG_EXP = /\A[a-zA-Z]*\z/.freeze

  belongs_to :addressable, polymorphic: true
  enum cast: { shipping: 0, billing: 1 }

  validates :cast, presence: true
  validates :phone, format: PHONE_REG_EXP, length: { maximum: 15 }, presence: true
  validates :first_name, format: NAME_REG_EXP, length: { maximum: 50 }, presence: true
  validates :address, format: ADDRESS_REG_EXP, length: { maximum: 50 }, presence: true
  validates :zip, format: ZIP_REG_EXP, length: { maximum: 10 }, presence: true
  validates :last_name, format: NAME_REG_EXP, length: { maximum: 50 }, presence: true
  validates :city, format: NAME_REG_EXP, length: { maximum: 50 }, presence: true
  validates :country, format: NAME_REG_EXP, length: { maximum: 50 }, presence: true
end
