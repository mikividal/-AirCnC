class Booking < ApplicationRecord
  belongs_to :country
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_date, :end_date, uniqueness: { scope: :country_id }
end
