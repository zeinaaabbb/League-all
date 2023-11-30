class LeagueTeamsJoinController < ApplicationController
  def create

  end

  def update

  end

  def destroy

  end

  def approve
    @join = LeagueTeamsJoin.find(params[:id])
    @join.accepted = true
    @join.save
    @league = @join.league
    redirect_to league_path(@league), notice: "#{@join.team.name} have been added to your league."
  end

  def reject
    @join = LeagueTeamsJoin.find(params[:id])
    @join.accepted = false
    @join.save
    @league = @join.league
    redirect_to league_path(@league), notice: "#{@join.team.name}'s request was rejected. They have not been added to your league."
  end
end
