class Battleship::Cell
  attr_reader :row, :col, :ship

  def initialize row, col
    @row, @col = row, col
    @fired_on  = false
    @ship      = nil
  end

  def fired_on!
    if fired_on?
      raise Game::IllegalMove, "This cell has already been fired on"
    else
      @fired_on = true
    end
  end
  def fired_on?
    @fired_on
  end

  def occupied_with! ship_name
    if has_ship?
      raise Game::IllegalMove, "Cell is already occupied"
    else
      @ship = ship_name
    end
  end
  def has_ship?
    !@ship.nil?
  end

  def hit?
    has_ship? && fired_on?
  end
end
