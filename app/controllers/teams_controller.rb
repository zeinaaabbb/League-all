class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @player = Player.new
    @accepted_players = @team.players.select { |player| player.accepted == true}


    @message = Message.new
    @selected_tab = params[:tab]
    @nearby_leagues = nearby_leagues_with_slots(@team)
    @markers = [{
      lat: @team.latitude,
      lng: @team.longitude
    }]

  end

  def new
    @user = current_user
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save!
      @chatroom = Chatroom.new
      @chatroom.team = @team
      @chatroom.name = @team.name
      @chatroom.save
      redirect_to dashboard_path(@team)
      flash[:message] = 'Your Team was Created Successfully!'
    else
      render :new, status: :unprocessible_entity
      flash[:message] = 'Missing Fields!'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)
    # No need for app/views/leagues/update.html.erb
    redirect_to dashboard_path(@team)
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to team_path(@team)
  end

  private

  def nearby_leagues_with_slots(team)
    nearby_leagues = League.near(team, 15)
    leagues_with_slots = []
    nearby_leagues.each do |league|
      accepted_joins = league.league_teams_joins.select { |join| join.accepted == true}
      slots = league.number_of_teams - accepted_joins.count
      if slots > 0
        leagues_with_slots << league
      end
    end
    return leagues_with_slots
  end

  def team_params
    params.require(:team).permit(:name, :photo, :location)
  end

end
