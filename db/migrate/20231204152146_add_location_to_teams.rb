class AddLocationToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :location, :string
  end
end
