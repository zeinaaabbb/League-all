class FavouritesController < ApplicationController

  def create
    @favourite = Favourite.new
    @league = League.find(params[:league_id])
    @favourite.league = @league
    @favourite.user = current_user

    if @favourite.save
      # render "leagues/index", leagues: League.all
      redirect_to leagues_path
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    if @favourite.destroy
      redirect_to leagues_path
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end
end
