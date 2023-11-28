# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'open-url'
require 'faker'
require 'date'

User.destroy_all
puts "Destroy all users"

League.destroy_all
puts "Destroy all leagues"

5.times do |i|
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 123456
  user.save!
  puts "#{user.email} created!"
end


format = [
  "round-robin",
  "double-round"
]

level = [
  "beginners",
  "intermediate",
  "advance"
]

league_type = [
  "5-a-side",
  "6-a-side",
  "7-a-side",
  "11-a-side"
]

name = [
  "Urban Bloom league",
  "Super 5 league",
  "The GoalPost league",
  "Roots&Boots Women's league",
  "Blossom Ballers Backyard League"
]

description = [
  "Founded in 2008, KickHer London is a grassroots women's football collective that has been breaking barriers and promoting inclusivity, creating a welcoming space for women of all skill levels to enjoy the beautiful game in the heart of the city",
  "The Hackney Women's Football Club, established in 2013, epitomizes grassroots football in London, fostering a sense of community and passion for the sport among local women through friendly matches, training sessions, and a commitment to development.",
  "With a mission to make football accessible to all women, the Camden Women's Football Club, formed in 2012, stands as a grassroots beacon in North London, offering a supportive environment for players to grow and enjoy the game."
]

(0...3).each do |i|
  league = League.new
  league.user = User.all.sample
  league.name = name[i]
  league.format = format.sample
  league.start_date = Date.today
  league.level = level.sample
  league.league_type = league_type.sample
  league.number_of_teams = rand(0..10)
  league.days_per_week = rand(0..5)
  league.description = description[i]
  league.save!
  puts "#{league.name} created!"
end
