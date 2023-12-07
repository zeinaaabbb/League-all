class FavouritesTeamController < ApplicationController

  def create
    @favourites_team = FavouritesTeam.new
    @team = Team.find(params[:team_id])
    @favourites_team.team = @team
    @favourites_team.user = current_user
    if @favourites_team.save
      redirect_to dashboard_path(tab: "browse")
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end

  def destroy
    @favourites_team = FavouritesTeam.find(params[:id])
    if @favourites_team.destroy
      redirect_back(fallback_location: root_path)
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end
end
