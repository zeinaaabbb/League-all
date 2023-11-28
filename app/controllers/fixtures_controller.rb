class FixturesController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @fixtures = @league.fixtures.all
  end

  def show
    @fixture = Fixture.find(params[:id])
  end

  def new
    @fixture = Fixture.new
  end

  def create
    @league = League.find(params[:league_id])
    @fixture = Fixture.new(fixture_params)
    @fixture.league = @league
    if @fixture.save!
      redirect_to league_path(@league)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @fixture = Fixture.find(params[:id])
  end

  def update
    @fixture = Fixture.find(params[:id])
    @fixture.update(params[:fixture])
    redirect_to fixtures_path(params[:league_id]), notice: 'Fixture successfully updated.'
  end

  def destroy
    @fixture = Fixture.find(params[:id])
    @fixture.destroy!
    redirect_to fixtures_path(params[:league_id])
  end

  private

  def fixture_params
    params.require(:fixture).permit(:home_team_id, :away_team_id, :gameweek, :time, :home_goals, :away_goals)
  end
end
