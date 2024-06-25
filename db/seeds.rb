# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a default admin user
User.create_with(password: "password", role: :admin).find_or_create_by!(email: "admin@example.com")

# Create 100 sample users
100.times do |i|
  User.create_with(password: "password").find_or_create_by!(email: "user_#{i}@example.com")
end
