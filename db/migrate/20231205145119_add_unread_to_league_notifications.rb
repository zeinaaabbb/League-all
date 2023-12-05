class AddUnreadToLeagueNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :league_notifications, :unread, :boolean
  end
end
