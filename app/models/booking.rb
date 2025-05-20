class Booking < ApplicationRecord
  belongs_to :country
  belongs_to :user
  validates :date, presence: true
  validates :date, uniqueness: { scope: :country_id }
end
