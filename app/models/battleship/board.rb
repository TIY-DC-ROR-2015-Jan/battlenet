class Battleship::Board
  def self.from_json data
    board = self.new

    data.each do |row|
      row.each do |cell|
        if cell["fired_on"]
          board.fire_on! cell["row"], cell["col"]
        end
        if cell["ship"]
          board.cell_at(cell["row"], cell["col"]).occupied_with! cell["ship"]
        end
      end
    end
    board
  end

  attr_reader :rows

  def initialize
    @rows = 10.times.map do |row|
      10.times.map do |col|
        Battleship::Cell.new row, col
      end
    end
  end

  def as_json *args
    @rows.as_json *args
  end

  def cell_at row, col
    if row.to_i > @rows.length
      raise Game::IllegalMove, "Row is out of bounds"
    elsif col.to_i > @rows[row.to_i].length
      raise Game::IllegalMove, "Col is out of bounds"
    else
      @rows[row.to_i][col.to_i]
    end
  rescue StandardError => e
    raise Game::IllegalMove, "Cell is out of bounds"
  end

  def fire_on! row, col
    cell_at(row, col).fired_on!
  end

  def place_ship! ship, row:, col:, dir:
    cells = if dir == "right"
      0.upto(ship.length - 1).map { |i| cell_at(row, col + i) }
    else
      0.upto(ship.length - 1).map { |i| cell_at(row + i, col) }
    end
    cells.each { |c| c.occupied_with! ship.name }
  end

  def each_cell &block
    @rows.each do |row|
      row.each do |cell|
        # yield cell
        block.call cell
      end
    end
  end

  def lost?
    each_cell do |c|
      if c.has_ship? && !c.fired_on?
        return false
      end
    end
    return true
  end

  def placed_ships
    seen = Set.new
    each_cell { |c| seen << c.ship if c.ship }
    seen
  end

  def next_ship_to_place
    Battleship.ships.reject { |s| placed_ships.include? s.name }.first
  end

  def need_to_place_ships?
    next_ship_to_place.present?
  end
end
