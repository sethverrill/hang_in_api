# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Poster.create(name: "LAZINESS",
  description: "You can't change anything.",
  price: 25.00,
  year: 2022,
  vintage: false,
  img_url: "./assets/laziness.jpg",
)
 Poster.create(name: "PROCRASTINATION",
  description: "Better to avoid failure by not trying at all.",
  price: 48.00,
  year: 2017,
  vintage: true,
  img_url: "./assets/procrastination.jpg",
 ),
Project.create(name: "DESPAIR",
  description: "Let someone else do it; you’ll just mess it up.",
  price: 73.00,
  year: 2015,
  vintage: false,
  img_url: "./assets/despair.jpg",
)