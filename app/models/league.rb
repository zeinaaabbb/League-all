require "round_robin_tournament"
class League < ApplicationRecord
  validates :name, :format, :level, :league_type, presence: true
  validates :start_date, presence: true
  validates :number_of_teams, presence: true
  validates :days_per_week, presence: true
  validates :description, length: { minimum: 10 }, presence: true
  has_many :favourites, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:name, :location]

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates :location, presence: true

  has_many :league_teams_joins
  has_many :teams, through: :league_teams_joins

  has_many :fixtures
  has_many :league_notifications, dependent: :destroy

  has_many :points
  belongs_to :user

  has_one_attached :photo

  def create_fixtures
    teams = RoundRobinTournament.schedule(self.teams.select { |t| true })

    teams.each_with_index do |day, index|
      day_teams = day.shuffle.map do |team|
        fixture = Fixture.new(
          gameweek: index + 1,
          home_team: team.first,
          away_team: team.last,
          league: self,
        )
        fixture.save
      end
    end
  end

end
