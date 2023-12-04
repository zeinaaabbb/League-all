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

    @selected_tab = params[:tab] unless params.nil?

    # raise
  end
end
