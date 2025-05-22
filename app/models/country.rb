class Country < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :name, uniqueness: true
  validates :name, :price, :main_language, :description, :tag_line, :capital_city, presence: true
end
