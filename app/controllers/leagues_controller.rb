class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
    @teams = @league.teams

    tally(@teams)
    @results.sort_by! { |team_data| [team_data[:points], team_data[:goal_dif], team_data[:goals_for]] }.reverse!
  end

  def new
    @user = current_user
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.user = current_user
    if @league.save
      redirect_to dashboard_path(@league)
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

  def tally(teams)
    @results = []

    teams.each do |team|
      team_data = {
        goals_for: 0,
        goals_against: 0,
        goal_dif: 0,
        wins: 0,
        losses: 0,
        draws: 0,
        points: 0,
        games_played: 0
      }

      team_data[:name] = team.name
      fixtures = Fixture.select { |f| (f.league == @league) && (f.home_team.id == team.id || f.away_team.id == team.id ) }
      fixtures.each do |f|
        f.home_team.id == team.id ? team_data[:goals_for] += f.home_goals : team_data[:goals_for] += f.away_goals
        f.home_team.id == team.id ? team_data[:goals_against] += f.away_goals : team_data[:goals_against] += f.home_goals
        if f.draw
          team_data[:draws] += 1
          team_data[:points] += 1
        end
        if f.home_team.id == team.id
          team_data[:wins] += 1 if f.home_goals > f.away_goals
          team_data[:losses] += 1 if f.away_goals > f.home_goals
          team_data[:points] += 3 if f.home_goals > f.away_goals
        end
        unless f.home_team.id == team.id
          team_data[:wins] += 1 if f.away_goals > f.home_goals
          team_data[:losses] += 1 if f.home_goals > f.away_goals
          team_data[:points] += 3 if f.away_goals > f.home_goals
        end
      end
      team_data[:goal_dif] = team_data[:goals_for] - team_data[:goals_against]
      team_data[:games_played] = fixtures.count

      @results << team_data
    end
    @results
  end
end
