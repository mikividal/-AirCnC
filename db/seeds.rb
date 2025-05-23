# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Clearing database..."
Booking.destroy_all
Country.destroy_all
User.destroy_all

puts "Creating users..."

user1 = User.create!(user_name: "carlover123", first_name: "Murray", email: "carlo@lewagon.com", password: "1234569")
user2 = User.create!(user_name: "speedster", first_name:"Messi", email: "speed@lewagon.com", password: "1234568")
user3 = User.create!(user_name: "eco", first_name: "Issac", email: "eco@lewagon.com", password: "1234567")
user4 = User.create!(user_name: "bruno08", first_name: "Bruno", email: "bruno@lewagon.com", password: "12345678")


puts "#{User.count} created"

puts "Creating countries..."

puts "Creating countries..."

hungary = Country.create!(
  name: "Hungary",
  capital_city: "Budapest",
  price: "1000000",
  tag_line: "Land of palinka and thermal baths",
  description: "Hungary is a landlocked gem in Central Europe, famed for its sweeping Danube vistas, thermal baths and hearty paprika-spiced cuisine.",
  main_language: "Hungarian",
  user: user1
)

hungary.photos.attach(
  io: File.open(Rails.root.join("app/assets/images/hungary.jpg")),
  filename: "hungary.jpg",
  content_type: "image/jpg"
)

argentina = Country.create!(
  name: "Argentina",
  capital_city: "Buenos Aires",
  price: "1200000",
  tag_line: "Land of tango and steak",
  description: "Argentina is a vibrant South American country known for tango, delicious beef, and stunning landscapes from Patagonia to Iguazu Falls.",
  main_language: "Spanish",
  user: user2
)

argentina.photos.attach(
  io: File.open(Rails.root.join("app/assets/images/argentina.jpg")),
  filename: "argentina.jpg",
  content_type: "image/jpg"
)

maldives = Country.create!(
  name: "Maldives",
  capital_city: "Male",
  price: "5000000",
  tag_line: "Paradise island",
  description: "The Maldives is an archipelago of crystalline turquoise atolls, where overwater villas, vibrant coral reefs and serene white-sand beaches define island paradise",
  main_language: "Dhivehi",
  user: user3
)
maldives.photos.attach(
  io: File.open(Rails.root.join("app/assets/images/maldives.jpg")),
  filename: "maldives.jpg",
  content_type: "image/jpg"
)

brazil = Country.create!(
  name: "Brazil",
  capital_city: "Brasilia",
  price: "12000000",
  tag_line: "Samba vibes only!",
  description: "Brazil is the largest country in South America and the fifth largest nation in the world. It forms an enormous triangle on the eastern side of the continent with a 4,500-mile (7,400-kilometer) coastline along the Atlantic Ocean. It has borders with every South American country except Chile and Ecuador",
  main_language: "Portugese",
  user: user4
)

brazil.photos.attach(
  io: File.open(Rails.root.join("app/assets/images/brazil.jpg")),
  filename: "brazil.jpg",
  content_type: "image/jpg"
)

puts "#{Country.count} created"
