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

require 'open-uri'
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
user_photos = ["https://assets.manutd.com/AssetPicker/images/0/0/19/9/1247499/27_Mary_Earps1694729780796.jpg", "https://b.fssta.com/uploads/application/soccer/headshots/33182.vresize.350.350.medium.49.png", "https://static.independent.co.uk/2023/08/18/13/34fb6e615ac670c3782c33c1a86c1387Y29udGVudHNlYXJjaGFwaSwxNjkyNDQ1NjEw-2.73361980.jpg", "https://img.chelseafc.com/image/upload/f_auto,h_390,q_90/editorial/people/ladies/2023-24/Lauren_James_profile_23-24_with_sponsor_headshot.png", "https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/06B1/production/_129231710_gettyimages-1475923306.jpg"]

5.times do |i|
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 123456
  file = URI.open(user_photos.sample)
  user.photo.attach(io: file, filename: "user.png", content_type: "image/png")
  user.save!
  puts "#{user.email} created!"
end

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
  "Roots&Boots Women's league",
  "Blossom Ballers Backyard League"
]

locations = ["Kensington", "Chelsea", "Camden", "Islington", "Greenwich", "Hackney", "Westminster", "Hammersmith", "Fulham", "Tower Hamlets", "Southwark", "Lambeth", "Wandsworth", "Haringey", "Ealing", "Brent", "Richmond", "Croydon", "Barking", "Dagenham"]


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
  league.location = locations.sample
  league.level = level.sample
  league.league_type = league_type.sample
  league.number_of_teams = rand(0..10)
  league.days_per_week = rand(0..5)
  league.description = description.sample
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
    team.location = locations.sample
    team.save!
    teams_array << team
    puts "#{team.name} created!"

    LeagueTeamsJoin.create!(team: team, league: league, accepted: true)
    puts "#{team.name} joined #{league.name}!"
  end
  teams << teams_array

end

# USER FOR FOLLOWING LEAGUE
user = User.new
user.first_name = "Leo"
user.last_name = "Messi"
user.email = "messi@test.com"
user.password = 123456
user.save!
puts "#{user.email} TEST USER created!"

# FOLLOWING LEAGUE FOR MIDWAY DEMO
following_league = League.new
following_league.user = User.last
following_league.name = "The GoalPost League"
following_league.format = format.sample
following_league.start_date = Date.today
following_league.location = locations.sample
following_league.level = level.sample
following_league.league_type = league_type.sample
following_league.number_of_teams = 10
following_league.days_per_week = rand(0..5)
following_league.description = description.sample
following_league.save!
puts "#{following_league.name} created!"

9.times do
  team = Team.new
  team.name = "#{Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')} #{suffixes.sample}"
  team.user = User.all.sample
  team.location = locations.sample
  team.save!
  puts "#{team.name} created!"

  LeagueTeamsJoin.create!(team: team, league: following_league, accepted: true)
  puts "#{team.name} joined #{following_league.name}!"
end

user = User.new
user.first_name = "Pep"
user.last_name = "Guardiola"
user.email = "pep@test.com"
user.password = 123456
user.save!
puts "#{user.email} TEST USER created!"



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
