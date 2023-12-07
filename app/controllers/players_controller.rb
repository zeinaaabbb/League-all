class PlayersController < ApplicationController
  def create
    @player = Player.new
    @team = Team.find(params[:team_id])
    @user = User.find(params[:format])
    @player.team = @team
    @player.user = @user
    if @player.save!
      redirect_to team_path(@team, tab: "players"), notice: "Your request has been submitted. The owner of #{@team.name} will respond soon."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def approve
    @player = Player.find(params[:id])
    @player.accepted = true
    @player.save
    @team = @player.team
    redirect_to team_path(@team, tab: "players"), notice: "#{@player.user.first_name} #{@player.user.last_name} has been added to #{@team.name}."
  end

  def reject
    @player = Player.find(params[:id])
    @player.accepted = false
    @player.save
    @team = @player.team
    redirect_to team_path(@team, tab: "players"), notice: "#{@player.user.first_name} #{@player.user.last_name}'s request was rejected. They have not been added to #{@team.name}."
  end

end
