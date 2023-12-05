class LeagueTeamsJoinController < ApplicationController
  def create
    @league_team = LeagueTeamsJoin.new(league_teams_join_params)
    @league = League.find(params[:league_id])
    @team = Team.find(params[:league_teams_join][:team_id])
    @league_team.team = @team
    @league_team.league = @league
    if LeagueTeamsJoin.where(team_id: @team.id, league_id: @league.id) == nil
      if @league_team.save!
        redirect_to league_path(@league), notice: "Your request has been submitted. The owner of #{@league.name} will respond soon."
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to league_path(@league), notice: "You have already sent a request for #{@league.name}. The league owner will respond soon."
    end
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

  private

  def league_teams_join_params
    params.require(:league_teams_join).permit(:team_id)
  end
end
