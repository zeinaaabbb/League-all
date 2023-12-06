
class Team < ApplicationRecord
  validates :name, length: { minimum: 4 }, presence: true
  validates :location, presence: true
  has_one_attached :photo
  has_many :players, dependent: :destroy
  has_many :users, through: :players
  has_many :home_fixtures, foreign_key: 'home_team_id', class_name: 'Fixture'
  has_many :away_fixtures, foreign_key: 'away_team_id', class_name: 'Fixture'
  has_many :messages, dependent: :destroy
  has_many :chatrooms, dependent: :destroy


  geocoded_by :location

  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  multisearchable against: [:name, :location]


  has_many :favourites_teams, dependent: :destroy

  has_many :league_teams_joins
  has_many :leagues, through: :league_teams_joins

  has_many :points

  belongs_to :user

end
