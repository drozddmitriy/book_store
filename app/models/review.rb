class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :published, -> { where(publish: true) }
  scope :unpublished, -> { where(publish: false) }

  validates :title, :comment, :rating, presence: true
end
