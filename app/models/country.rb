class Country < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: true
  validates :name, :price, :main_language, :description, :tag_line, presence: true
  has_many :bookings
end
