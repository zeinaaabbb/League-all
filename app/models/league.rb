class League < ApplicationRecord
  validates :name, :format, :level, :league_type, presence: true
  validates :start_date, presence: true
  validates :number_of_teams, presence: true
  validates :days_per_week, presence: true
  validates :descriptions, length: { minimum: 10 }, presence: true

  has_many :teams, through: :leagues_team_join
  has_many :fixtures
  has_many :league_notifications
  belongs_to :users

  has_one_attached :photo
end
