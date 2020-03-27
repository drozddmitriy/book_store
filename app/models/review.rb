class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :published, -> { where(publish: true) }
  scope :unpublished, -> { where(publish: false) }

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_then: 0,
                                     less_than_or_equal_to: 5 }

  validates :title, length: { maximum: 80 }, presence: true
  validates :comment, length: { maximum: 500 }, presence: true
end
