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
    board_json = state[user.id]
    Board.from_json board_json
  end
end
