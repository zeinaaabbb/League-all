# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'pry'
require "open-uri"

# require 'open-url'
require 'faker'
require 'date'
require "round_robin_tournament"

# DESTROY FIXTURE
puts "destroying fixtures"
Fixture.destroy_all
puts "fixtures destroyed"
# END

# DESTROY LEAGUE TEAMS JOIN
puts "Destroying LeagueTeamsJoin"
LeagueTeamsJoin.destroy_all
puts "LeagueTeamsJoin destroyed"
# END

# DESTROY ALL TEAMS
puts "destroying teams"
Team.destroy_all
puts "teams destroyed"
# END

# DESTROY ALL LEAGUES
puts "Destrying all leagues"
League.destroy_all
puts "leagues destroyed"
# END

# DESTROY ALL USERS
puts "Destroying all users"
User.destroy_all
puts "Users destroyed"
# END

# SEEDING USERS
5.times do |i|
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 123456
  user.save!
  puts "#{user.email} created!"
end

user = User.new
user.first_name = "Leo"
user.last_name = "Messi"
user.email = "messi@test.com"
user.password = 123456
user.role = "Coach"
file = URI.open("https://www.partyrama.co.uk/wp-content/uploads/2018/04/pep-guardiola-manchester-city-manager-face-mask-product-image.jpg")
user.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
user.save!
puts "#{user.email} TEST USER created!"

user = User.new
user.first_name = "Pep"
user.last_name = "Guardiola"
user.email = "pep@test.com"
user.password = 123456
user.role = "Organiser"
file = URI.open("https://www.partyrama.co.uk/wp-content/uploads/2018/04/pep-guardiola-manchester-city-manager-face-mask-product-image.jpg")
user.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
user.save!
puts "#{user.email} TEST USER created!"
# SEEDING USERS END

# SEEDING LEAGUES
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

# SEEDING LEAGUES END

# SEEDING TEAMS

suffixes = ['United', 'Rovers', 'Albion', 'City', 'Town', 'FC', 'Athletic', 'Wanderers', 'Olympic', 'Orient', '']
teams = []
League.all.each do |league|
  teams_array = []
  10.times do
    team = Team.new
    team.name = "#{Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')} #{suffixes.sample}"
    team.user = User.all.sample
    team.save!
    teams_array << team
    puts "#{team.name} created!"

    LeagueTeamsJoin.create!(team: team, league: league)
    puts "#{team.name} joined #{league.name}!"
  end
  teams << teams_array

end

puts "TEAMS CREATED"
puts "_____________"
# SEEDING TEAMS END

# FIXTURES SECTION
puts "SEEDING FIXTURES"
puts "_____________"

League.first(3).each do |league|
  teams = RoundRobinTournament.schedule(league.teams.select { |t| true })

  teams.each_with_index do |day, index|
    puts "Gameweek #{index + 1}"
    day_teams = day.shuffle.map do |team|
      puts "#{team.first.name}, #{team.last.name}"
      fixture = Fixture.new(
        gameweek: index + 1,
        home_team: team.first,
        away_team: team.last,
        league: league,

        # Simulating the score
        home_goals: [1, 2, 3, 4, 5].sample,
        away_goals: [1, 2, 3, 4, 5].sample,

        time: Faker::Time.between_dates(from: Date.today - 1, to: Date.today + 7, period: :all)
      )

      fixture.draw = true if fixture.home_goals == fixture.away_goals

      fixture.winning_team = fixture.home_team.id if fixture.home_goals > fixture.away_goals

      fixture.winning_team = fixture.away_team.id if fixture.home_goals < fixture.away_goals

      fixture.save
    end
    puts "-------------------------------"
  end
end
# FIXTURES END
