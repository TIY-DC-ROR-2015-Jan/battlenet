class BattleshipsController < ApplicationController
  def index
    @games = current_user.games.battleship
  end

  def new
    @game = current_user.games.battleship.new
  end

  def create
    opponent = User.find params[:opponent_id]
    game = Battleship.start_game current_user, opponent
    redirect_to battleship_path(game)
  end

  def show
    @game  = current_user.games.battleship.find params[:id]
    @board = @game.board_for_user current_user
  end

  def update
    game = current_user.games.battleship.find params[:id]
    begin
      game.record_move current_user, row: params[:row], col: params[:col]
    rescue Game::IllegalMove => e
      flash[:error] = "Illegal move: #{e}"
    end
    redirect_to battleship_path(game)
  end
end
