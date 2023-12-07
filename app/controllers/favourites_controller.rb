class FavouritesController < ApplicationController

  def create
    @favourite = Favourite.new
    @league = League.find(params[:league_id])
    @favourite.league = @league
    @favourite.user = current_user

    if @favourite.save
      redirect_to dashboard_path(tab: "browse")
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    if @favourite.destroy
      redirect_back(fallback_location: root_path)
    else
      render "leagues/index", status: :unprocessible_entity
    end
  end
end
