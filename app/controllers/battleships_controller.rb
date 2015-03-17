class BattleshipsController < ApplicationController
  def index
    @games = current_user.games.battleship
  end
end
