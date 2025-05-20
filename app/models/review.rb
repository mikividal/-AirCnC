class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, format: { with: /\A\d(\.\d{1})?\z/ }, presence: true
  validates :comment, presence: true
end
