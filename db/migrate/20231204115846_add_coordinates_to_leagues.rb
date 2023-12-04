class AddCoordinatesToLeagues < ActiveRecord::Migration[7.1]
  def change
    add_column :leagues, :latitude, :float
    add_column :leagues, :longitude, :float
  end
end
