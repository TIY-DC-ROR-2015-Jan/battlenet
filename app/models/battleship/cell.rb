class Battleship::Cell
  attr_reader :row, :col

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

  def has_ship?
    !@ship.nil?
  end

  def hit?
    has_ship? && fired_on?
  end
end
