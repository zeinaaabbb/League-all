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

puts 'running seed'

home_team = Team.map { |team| team.find(:id).even? }
away_team = Team.map { |team| team.find(:id).odd? }

binding.pry

5.times do
  fixture = Fixture.new
  fixture.gameweek = rand(1..10)
  fixture.time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today + 7, period: :all)
  fixture.home_goals = rand(1..5)
  fixture.away_goals = rand(1..5)
  fixture.home_team_id_id = home_team.shift
  fixture.away_team_id_id = away_team.shift
end

puts 'finished seed'
