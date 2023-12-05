class LeagueNotificationsController < ApplicationController
  before_action :set_league_notification, only: %i[show edit update destroy]

  def index
    @league_notifications = LeagueNotification.all
  end

  def show

  end

  def new
    @league_notification = LeagueNotification.new
  end

  def edit

  end

  def create
    league = League.find(params[:league_id])
    @league_notification = LeagueNotification.new(league_notification_params)
    @league_notification.user = current_user
    @league_notification.league = league
    @league_notification.unread = true
    if @league_notification.save
      redirect_to league_path(league), notice: 'League notification was successfully created.'
    else
      render :new
    end
  end

  def update
    if @league_notification.update(league_notification_params)
      redirect_to @league_notification, notice: 'League notification was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @league_notification.destroy
    redirect_to league_path(league), notice: 'League notification was successfully destroyed.'
  end

  def mark_as_read
    @league_notification = LeagueNotification.find(params[:id])
    @league_notification.update(unread: false)
    redirect_to league_path(league), notice: 'Notification marked as read.'
  end


  private

  def set_league_notification
    @league_notification = LeagueNotification.find(params[:id])
  end

  def league_notification_params
    params.require(:league_notification).permit(:league_id, :user_id, :content)
  end
end
