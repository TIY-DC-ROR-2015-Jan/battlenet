class Battleship < Game
  def self.start_game p1,p2
    game = Battleship.create!({
      current_player_id: p1.id,
      state: {
        p1.id => Board.new,
        p2.id => Board.new
      }
    })
    game.players.push p1
    game.players.push p2
  end

  def board_for_user user
    board_json = state[user.id.to_s]
    Board.from_json board_json
  end

  def need_to_place_ships?
    false
  end

  def player_turn? user
    current_player_id == user.id
  end

  def record_move user, row:, col:
    unless player_turn? user
      raise IllegalMove, "It's not your turn"
    end
    board = board_for_user user
    board.fire_on! row, col
    state[user.id] = board
    save!
  end
end
