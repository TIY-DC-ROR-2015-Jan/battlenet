class Battleship::Cell
  def initialize row, col
    @row, @col = row, col
    @fired_on  = false
    @ship      = nil
  end
end
