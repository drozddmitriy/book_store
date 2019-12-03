class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :firstname, :lastname, :address, :city, :zip, :country, :phone, :cast, presence: true
  validates :firstname, :lastname, :city, :country, format: { with: /\A[a-zA-Z]*\z/ }, length: { maximum: 50 }
  validates :phone, format: { with: /\A\+[0-9]*\z/ }, length: { maximum: 15 }
  validates :address, format: { with: /\A[a-zA-Z0-9 \-\,]*\z/ }, length: { maximum: 50 }
  validates :zip, format: { with: /\A[0-9\-]*\z/ }, length: { maximum: 10 }
  validates :firstname, :lastname, :city, :country,
            format: { with: /\A[a-zA-Z]*\z/ }, length: { maximum: 50 }
  enum cast: { shipping: 0, billing: 1 }
end
