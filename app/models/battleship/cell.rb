class Battleship::Cell
  def initialize row, col
    @row, @col = row, col
    @fired_on  = false
    @ship      = nil
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
