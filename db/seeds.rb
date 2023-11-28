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
require 'pry'

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

# DESTROY FIXTURE
puts "destroying fixtures"
Fixture.destroy_all
puts "fixtures destroyed"

puts 'running seed'

# SEEDING FIXTURES

home_team = Team.all.select { |team| team.id.even? }
away_team = Team.all.select { |team| team.id.odd? }


5.times do
  fixture = Fixture.new
  fixture.gameweek = rand(1..10)
  fixture.time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today + 7, period: :all)
  fixture.home_goals = rand(1..5)
  fixture.away_goals = rand(1..5)
  fixture.home_team = home_team.shift
  fixture.away_team = away_team.shift
  fixture.save!
end

puts 'finished seed'
