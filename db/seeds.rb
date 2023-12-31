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
user_photos = ["https://assets.manutd.com/AssetPicker/images/0/0/19/9/1247499/27_Mary_Earps1694729780796.jpg",
  "https://b.fssta.com/uploads/application/soccer/headshots/33182.vresize.350.350.medium.49.png",
  "https://static.independent.co.uk/2023/08/18/13/34fb6e615ac670c3782c33c1a86c1387Y29udGVudHNlYXJjaGFwaSwxNjkyNDQ1NjEw-2.73361980.jpg",
  "https://img.chelseafc.com/image/upload/f_auto,h_390,q_90/editorial/people/ladies/2023-24/Lauren_James_profile_23-24_with_sponsor_headshot.png",
  "https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/06B1/production/_129231710_gettyimages-1475923306.jpg",
  "https://media.newyorker.com/photos/64b58f2c1f95b9ee5ffdb410/master/pass/Zhou-Sam-Kerr.jpg",
  "https://media.newyorker.com/photos/5d111443ad33b0208e862486/master/pass/Thomas-Marta.jpg",
  "https://static.independent.co.uk/2023/02/24/19/b863ab6e26e43119a8b693a96e316b01Y29udGVudHNlYXJjaGFwaSwxNjc3MzUwMjY0-2.68014900.jpg",
  "https://www.getfootballnewsfrance.com/assets/fbl-eur-c1-women-bayern-munich-psg.jpg",
  "https://cloudfront-us-east-1.images.arcpublishing.com/pmn/CMUH5VOIFZD5JCHCUHRJZTNKWQ.jpg",
  "https://www.sarkariexam.com/wp-content/uploads/2023/08/Kadidiatou-Diani-Parents-French-footballer-Family-Ethnicity-and-Origin.jpg",
  "https://cdn.vox-cdn.com/thumbor/p3d2snDzAOAclZllBmxCxF4zM38=/0x0:3839x2879/1200x0/filters:focal(0x0:3839x2879):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/23203590/1359420368.jpg",
  "https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/D19E/production/_123626635_asisatoshoala.jpg",
  "https://i.dailymail.co.uk/1s/2023/08/03/14/73925149-12369393-image-a-1_1691069869735.jpg",
  "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2023-07/Sophia-smith-me-230722-43b2b7.jpg"]

15.times do |i|
  user = User.new
  user.first_name = Faker::Name.female_first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}.#{user.last_name}@fakeemail.com"
  user.password = 123456
  file = URI.open(user_photos[i])
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

league_images = ["https://www.uknewsgroup.co.uk/wp-content/uploads/2023/08/Kirby-Muxloe-Ladies-FC.jpg", "https://c8.alamy.com/comp/2CF2XK3/dulwich-hamlet-women-vs-saltdean-united-women-8th-march-2020-2CF2XK3.jpg", "https://images.squarespace-cdn.com/content/v1/615ef1f9564d0c36fc18fb2c/bf99876e-5d61-4462-bcbc-0029f5ce5c68/Remove+background.png", "https://toyworldmag.co.uk/wp-content/uploads/2022/07/My-Top-Trumps.jpg"]

locations = ["Kensington, London", "Chelsea, London", "Camden, London", "Islington, London", "Greenwich, London", "Hackney, London", "Westminster, London", "Hammersmith, London", "Fulham, London", "Tower Hamlets, London", "Southwark, London", "Lambeth, London", "Wandsworth, London", "Haringey, London", "Ealing, London", "Brent, London", "Richmond, London", "Croydon, London", "Barking, London", "Dagenham, London"]

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
  file = URI.open(league_images[i])
  league.photo.attach(io: file, filename: "league.png", content_type: "image/png")
  league.description = description.sample
  league.save!
  puts "#{league.name} created!"
end

# SEEDING LEAGUES END

# SEEDING TEAMS

team_photos = ["https://cached.imagescaler.hbpl.co.uk/resize/scaleHeight/815/cached.offlinehbpl.hbpl.co.uk/news/OMC/Nike11-20190719115407953.jpg", "https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/042D/production/_128496010_manchesterlacesplay.jpg", "https://d2x51gyc4ptf2q.cloudfront.net/content/uploads/2021/03/29214616/Romance-FC-huddle.jpg", "https://images-stylist.s3-eu-west-1.amazonaws.com/app/uploads/2022/07/25154855/euros-grassroots.jpg", "https://sponsorgrassroots.co.uk/uploads/teams/broomhill-sports-club-recreational-women-s-football/522/BtjrS17jdWW1EvDzT1DcSENSALnCYBid5Gc6NtjW.jpg", "https://gtfc.co.uk/wp-content/uploads/2022/04/Women_Arnold_Game-scaled.jpg", "https://ffprod.blob.core.windows.net/media/1V2A3433resized-optimised.jpg", "https://www.ntfc.co.uk/siteassets/image/202324-season/women_team_2324.jpg", "https://myclubpro.blob.core.windows.net/images/News/1036/431432/DSC03354.jpg", "https://since-71.com/wp-content/uploads/2023/09/Bath_Weymouth_3Sep23_0445-2-800x500.jpg"]

suffixes = ['United', 'Rovers', 'Albion', 'City', 'Town', 'FC', 'Athletic', 'Wanderers', 'Olympic', 'Orient', '']
teams = []
League.all.each do |league|
  teams_array = []
  (0...10).each do |i|
    team = Team.new
    location = Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')
    team.location = "#{location}, London, UK"
    team.name = "#{location} #{suffixes.sample}"
    team.user = User.all.sample
    file = URI.open(team_photos[i])
    team.photo.attach(io: file, filename: "team.png", content_type: "image/png")
    team.save!
    teams_array << team
    puts "#{team.name} created!"
    Chatroom.create(name: team.name, team_id: team.id)

    LeagueTeamsJoin.create!(team: team, league: league, accepted: true)
    puts "#{team.name} joined #{league.name}!"
  end
  teams << teams_array

end

# CREATING PLAYERS FOR FIRST TEAM
team = League.first.teams.first
User.last(10).each do |user|
  Player.create!(
    user: user,
    team: team,
    accepted: true
  )
end

puts "Players created"

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



# ! SEEDS FOR DEMO
# USER FOR FOLLOWING LEAGUE
user = User.new
user.first_name = "Alexia"
user.last_name = "Putellas"
user.email = "alexia@test.com"
file = URI.open("https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/12C22/production/_122743867_putellas_getty.jpg")
user.photo.attach(io: file, filename: "user.png", content_type: "image/png")
user.password = 123456
user.save!
puts "#{user.email} TEST USER created!"

# FOLLOWING LEAGUE FOR MIDWAY DEMO
following_league = League.new
following_league.user = User.last
following_league.name = "The GoalPost League"
following_league.format = format.sample
following_league.start_date = Date.today
following_league.location = "Wapping, London, UK"
following_league.level = level.sample
following_league.league_type = league_type.sample
following_league.number_of_teams = 10
following_league.days_per_week = rand(0..5)
file = URI.open("https://www.yellowad.co.uk/wp-content/uploads/2022/10/City-v-Southend-ECWFL.jpeg")
following_league.photo.attach(io: file, filename: "league.png", content_type: "image/png")
following_league.description = description.sample
following_league.save!
puts "#{following_league.name} created!"

(0...9).each do |i|
  team = Team.new
  team.user = User.all.sample
  location = Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')
  team.location = "#{location}, London, UK"
  team.name = "#{location} #{suffixes.sample}"
  file = URI.open(team_photos[i])
  team.photo.attach(io: file, filename: "team.png", content_type: "image/png")
  team.save!
  puts "#{team.name} created!"
  Chatroom.create(name: team.name, team_id: team.id)
  LeagueTeamsJoin.create!(team: team, league: following_league, accepted: true)
  puts "#{team.name} joined #{following_league.name}!"
end

user = User.new
user.first_name = "Zeinab"
user.last_name = "Warsama"
user.email = "zeinab@test.com"
user.password = 123456
file = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1698358674/shylm0dpj9wcfx37jho9.jpg")
user.photo.attach(io: file, filename: "zeinab.png", content_type: "image/png")
user.save!
puts "#{user.email} TEST USER created!"

ladies = Team.new
ladies.user = User.last
ladies.location = "Hackney, London, UK"
ladies.name = "East London Ladies"
file = URI.open(team_photos.sample)
ladies.photo.attach(io: file, filename: "team.png", content_type: "image/png")
ladies.save!
puts "#{ladies.name} created!"
Chatroom.create(name: ladies.name, team_id: ladies.id)

(10).times do |i|
  Player.create!(
    user: User.all[i],
    team: Team.last,
    accepted: true
  )
end

(2).times do |i|
  Player.create!(
    user: User.last(5)[i],
    team: Team.last,
    accepted: nil
  )
end

messages = ["Excited to be a member of this team!", "Me too, can't wait for our first match", "do we know when that is yet?", "Not yet, coach is finding a league to join", "does anyone have some shinpads I could buy/borrow?", "Yeah I do", "This app is so good for this", "Yeah!", "Agreed! So glad i don't have to wrestle with a million whatsapp groups any more", "We still need a couple more players here, so please share the link to our page with your friends :)"]

(0...10).each do |i|
  Message.create!(
    user: User.all[i],
    team: Team.last,
    chatroom: Chatroom.last,
    content: messages[i]
  )
end

urban_bloom = League.find_by(name:"Urban Bloom league")
urban_bloom.user = User.last(2)[0]
urban_bloom.save!
unscored_fixture = Fixture.where(league_id: League.find_by(name:"Urban Bloom league").id, gameweek: 9)[4]
unscored_fixture.home_goals = nil
unscored_fixture.away_goals = nil
unscored_fixture.winning_team = nil
unscored_fixture.save!
