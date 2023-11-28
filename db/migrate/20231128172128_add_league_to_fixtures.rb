class AddLeagueToFixtures < ActiveRecord::Migration[7.1]
  def change
    add_reference :fixtures, :league, foreign_key: true
  end
end
