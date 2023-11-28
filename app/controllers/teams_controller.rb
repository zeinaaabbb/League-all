class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @user = current_user
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to team_path(@team)
    else
      render :new, status: :unprocessible_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to team_path(@team)
  end

  private

  def team_params
    params.require(:team).permit(:name, :photo)
  end

end
