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

    @selected_tab = params[:tab] unless params[:tab].nil?
  end
end
