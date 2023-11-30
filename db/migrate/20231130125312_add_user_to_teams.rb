class AddUserToTeams < ActiveRecord::Migration[7.1]
  def change
    add_reference :teams, :user, foreign_key: true
  end
end
