class AddCoordinatesToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :latitude, :float
    add_column :teams, :longitude, :float
  end
end
