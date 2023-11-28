class CreateFixtures < ActiveRecord::Migration[7.1]
  def change
    create_table :fixtures do |t|

      t.timestamps
    end
  end
end
