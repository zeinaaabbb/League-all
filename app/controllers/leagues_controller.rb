class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
    @league_teams_join = LeagueTeamsJoin.new
    @accepted_joins = @league.league_teams_joins.select { |join| join.accepted == true}
    @accepted_teams = @accepted_joins.map { |join| join.team}
    tally(@accepted_teams)
    @results.sort_by! { |team_data| [team_data[:points], team_data[:goal_dif], team_data[:goals_for]] }.reverse!

    @league_notifications = @league.league_notifications.order(created_at: :desc)
    Notification.find(params[:n_id]).update(read_at: Time.now) if current_user && params[:read] == "yes"
    @selected_tab = params[:tab]
    @slots = @league.number_of_teams - @accepted_joins.count

    @slots_available = @slots > 0
    @league_notifications = @league.league_notifications

    @markers = [{
      lat: @league.latitude,
      lng: @league.longitude
    }]
  end

  def new
    @user = current_user
    @league = League.new
  end

  def create

    @league = League.new(league_params)
    @league.user = current_user
    if @league.save!
      redirect_to dashboard_path(@league, tab: "leagues")
      flash[:message] = 'Your League was Created Successfully!'
    else
      render :new, status: :unprocessable_entity
      flash[:message] = 'Missing Fields!'
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    @league.update(league_params)
    # No need for app/views/leagues/update.html.erb
    redirect_to dashboard_path(@league, tab: "leagues")
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to league_path(@league), status: :see_other
  end

  def generate_fixtures
    @league = League.find(params[:league_id])
    @accepted_joins = @league.league_teams_joins.select { |join| join.accepted == true}
    @accepted_teams = @accepted_joins.map { |join| join.team}
    if @accepted_teams.count != 10
      redirect_to league_path(@league, tab: "fixtures"), notice: "Your league does not have enough teams to generate fixtures yet."
    else
      @league.create_fixtures
      redirect_to league_path(@league, tab: "fixtures"), notice: "Your fixtures have been generated."
    end
  end

  private

  def league_params
    params.require(:league).permit(:name, :format, :start_date, :level, :league_type, :number_of_teams, :days_per_week,:description, :photo, :location)
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
        if f.home_goals && f.away_goals
          team_data[:games_played] += 1
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
      end
      team_data[:goal_dif] = team_data[:goals_for] - team_data[:goals_against]

      @results << team_data
    end
    @results
  end
end
