class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @team = Team.new
    @league = League.new
    @user = current_user
    @teams = Team.all
    @leagues = League.all

    PgSearch::Multisearch.rebuild(Team)
    PgSearch::Multisearch.rebuild(League)
    unless params[:query].nil?
      @results = PgSearch.multisearch(params[:query])
      @selected_tab = 'browse'

      league_ids = @results.map { |result| result.searchable_id if result.searchable_type == "League" }
      @leagues = League.where(id: league_ids)

      team_ids = @results.map { |result| result.searchable_id if result.searchable_type == "Team" }
      @teams = Team.where(id: team_ids)
    end

    league_markers = @leagues.geocoded.map do |league|
      {
        lat: league.latitude,
        lng: league.longitude
      }
    end
    @markers = @teams.geocoded.map do |team|
      {
        lat: team.latitude,
        lng: team.longitude
      }
    end

    league_markers.each do |marker|
      @markers << marker
    end

    @selected_tab = params[:tab] unless params[:tab].nil?
  end
end
