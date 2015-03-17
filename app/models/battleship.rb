class Battleship < Game
  class Ship
    attr_reader :name, :length
    def initialize name, length
      @name, @length = name, length
    end
  end

  def self.ships
    {
      "Battleship"  => 4,
      "Carrier"     => 5,
      "Submarine"   => 3,
      "Destroyer"   => 3,
      "Patrol Boat" => 2
    }.map { |name, length| Ship.new(name, length) }
  end

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
    game
  end

  def board_for_user user
    board_json = state[user.id.to_s]
    Board.from_json board_json
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
    update! current_player_id: next_player.id
  end

  def next_player
    players.where.not(id: current_player_id).first
  end

  def opponent user
    players.where.not(id: user.id).first
  end

  def board_for_opponent user
    board_for_user opponent(user)
  end

  def place_ship user, row:, col:, dir:
    opp = opponent user
    opp_board = board_for_user opp
    opp_board.place_ship! opp_board.next_ship_to_place,
      row: row.to_i, col: col.to_i, dir: dir
    state[opp.id] = opp_board
    save!
  end

  def need_to_place_ships?
    players.any? { |p| board_for_user(p).need_to_place_ships? }
  end
end
