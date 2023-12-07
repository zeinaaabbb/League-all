class LeagueTeamsJoin < ApplicationRecord
  belongs_to :league
  belongs_to :team
  has_noticed_notifications
  after_create_commit :notify_user

  def notify_user
    CommentNotification.with(post: {content: "#{team.name} has requested to join #{league.name}", league: league}).deliver_later(league.user)
  end
end
