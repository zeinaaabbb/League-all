class AddFieldToFixtures < ActiveRecord::Migration[7.1]
  def change
    add_column :fixtures, :winning_team, :integer
    add_column :fixtures, :draw, :boolean
  end
end
