class LeagueTeamsJoin < ApplicationRecord
  belongs_to :league
  belongs_to :team
end
