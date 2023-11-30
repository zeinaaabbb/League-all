class Fixture < ApplicationRecord
  belongs_to :league
  belongs_to :home_team, foreign_key: 'home_team_id', class_name: 'Team'
  belongs_to :away_team, foreign_key: 'away_team_id', class_name: 'Team'
  validates :home_team, uniqueness: { scope: :away_team }
  validates :away_team, uniqueness: { scope: :home_team }
end
