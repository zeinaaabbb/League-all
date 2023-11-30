class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @user = current_user
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.user = current_user
    if @league.save
      redirect_to  dashboard_path(@league)
      flash[:message] = 'Your League was Created Successfully!'
    else
      render :new, status: :unprocessable_entity
      flash[:message] = 'Missing Fields!'
    end
  end

  private

  def league_params
    params.require(:league).permit(:name, :format, :start_date, :level, :league_type, :number_of_teams, :days_per_week,:description, :photos)
  end
end
