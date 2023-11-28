class CreateLeagueNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :league_notifications do |t|
      t.references :league, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
