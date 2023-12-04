class AddLocationToLeagues < ActiveRecord::Migration[7.1]
  def change
    add_column :leagues, :location, :string
  end
end
