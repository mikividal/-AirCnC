class Country < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, uniqueness: true
  validates :name, :capital_city, :price, :main_language, :description, :tag_line, presence: true

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
end
