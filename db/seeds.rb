# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# DESTROY ALL
puts "destroying teams"
Team.destroy_all
puts "teams destroyed"

# END

# SEEDING TEAMS
10.times do
  team = Team.new
  team.name = "#{Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')} #{Faker::Team.creature}"
  team.save!
  puts "#{team.name} created!"
end
