class AddTeamRefToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :team, null: false, foreign_key: true
  end
end
