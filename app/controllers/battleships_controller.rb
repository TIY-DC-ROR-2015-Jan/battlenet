class BattleshipsController < ApplicationController
  def index
    @games = current_user.games.battleship
  end

  def new
    @game = current_user.games.battleship.new
  end

  def create
    opponent = User.find params[:opponent_id]
    game = Battleship.create!
    game.players.push current_user
    game.players.push opponent
    redirect_to battleship_path(game)
  end

  def show
    @game  = current_user.games.battleship.find params[:id]
    @board = @game.board_for_user current_user
  end
end
