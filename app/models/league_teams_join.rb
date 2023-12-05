class LeagueTeamsJoin < ApplicationRecord
  belongs_to :league
  belongs_to :team
  belongs_to :user
end
