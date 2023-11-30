class Team < ApplicationRecord
  validates :name, length: { minimum: 4 }, presence: true
  has_one_attached :photo
  has_many :players
  has_many :users, through: :players
  has_many :fixtures
  has_many :messages
  has_many :league_teams_join
  has_many :leagues, through: :league_teams_join
end
