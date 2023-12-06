class LeagueNotification < ApplicationRecord
  has_noticed_notifications
  belongs_to :league
  belongs_to :user
  validates :content, presence: true
  after_create_commit :notify_user

  def notify_user
    league.teams.map(&:users).flatten.each { |user| CommentNotification.with(post: {content: content, league: league}).deliver_later(user) }
  end
end
