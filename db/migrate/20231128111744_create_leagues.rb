class CreateLeagues < ActiveRecord::Migration[7.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :format
      t.integer :start_date
      t.string :level
      t.string :league_type
      t.integer :number_of_teams
      t.integer :days_per_week
      t.text :description

      t.timestamps
    end
  end
end
