class CreateLeagues < ActiveRecord::Migration[7.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :format
      t.date :start_date
      t.string :level
      t.string :league_type
      t.integer :number_of_teams
      t.integer :days_per_week
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
