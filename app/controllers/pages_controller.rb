class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @team = Team.new
    @league = League.new
    @following_league = League.find_by(name: "The Le Wagon League")
    @user = current_user
  end
end
