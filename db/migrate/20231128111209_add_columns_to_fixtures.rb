class AddColumnsToFixtures < ActiveRecord::Migration[7.1]
  def change
    add_column :fixtures, :gameweek, :integer
    add_column :fixtures, :time, :datetime
    add_column :fixtures, :home_goals, :integer
    add_column :fixtures, :away_goals, :integer
    add_reference :fixtures, :home_team_id, foreign_key: { to_table: :teams }
    add_reference :fixtures, :away_team_id, foreign_key: { to_table: :teams }
  end
end
