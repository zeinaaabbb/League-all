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
    @
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private

  def fixture_params
    params.require(:fixture).permit()
  end
end
