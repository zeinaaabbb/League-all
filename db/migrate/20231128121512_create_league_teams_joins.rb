class CreateLeagueTeamsJoins < ActiveRecord::Migration[7.1]
  def change
    create_table :league_teams_joins do |t|
      t.boolean :accepted
      t.references :league, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
