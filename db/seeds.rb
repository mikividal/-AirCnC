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

user1 = User.create!(user_name: "carlover123", email: "carlo@lewagon.com", password: "1234569")
user2 = User.create!(user_name: "speedster", email: "speed@lewagon.com", password: "1234568")
user3 = User.create!(user_name: "eco", email: "eco@lewagon.com", password: "1234567")

puts "#{User.count} created"

puts "Creating countries..."

Country.create!(name: "Hungary", capital_city: "Budapest", price: "1000000", tag_line: "Land of palinka and thermal baths", description:"Hungary is a landlocked gem in Central Europe, famed for its sweeping Danube vistas, thermal baths and hearty paprika-spiced cuisine.", main_language: "Hungarian", user: user1)
Country.create!(name: "Argentina", capital_city: "Buenos Aires", price: "10000", tag_line: "The country of barbeque and football", description:"Argentina stretches from the windswept Pampas to the soaring Andes, offering fierce tango rhythms, world-class beef and boundless natural wonders.", main_language: "Spanish",  user: user2)
Country.create!(name: "Maldives", capital_city: "Male", price: "5000000", tag_line: "Paradise island", description:"The Maldives is an archipelago of crystalline turquoise atolls, where overwater villas, vibrant coral reefs and serene white-sand beaches define island paradise", main_language: "Dhivehi", user: user3)

puts "#{Country.count} created"
