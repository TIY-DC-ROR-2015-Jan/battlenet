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
    @board = if @game.need_to_place_ships?
      @game.board_for_opponent current_user
    else
      @game.board_for_user current_user
    end
  end

  def update
    game = current_user.games.battleship.find params[:id]
    begin
      if params[:thing_to_do] == "place"
        game.place_ship current_user, row: params[:row], col: params[:col], dir: params[:dir]
      else
        game.record_move current_user, row: params[:row], col: params[:col]
      end
    rescue Game::IllegalMove => e
      flash[:error] = "Illegal move: #{e}"
    end
    redirect_to battleship_path(game)
  end

  def ready
    game = current_user.games.battleship.find params[:id]
    render json: {
      current_player: User.find(game.current_player_id).email,
      ready: game.player_turn?(current_user)
    }
  end
end
