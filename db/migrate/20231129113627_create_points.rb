class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.references :team, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
