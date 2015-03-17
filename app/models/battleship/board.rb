class Battleship::Board
  def self.from_json data
    board = self.new
    data.each do |row|
      row.each do |cell|
        if cell["fired_on"]
          board.fire_on! cell["row"], cell["col"]
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
    @rows[row.to_i][col.to_i]
  rescue => e
    raise Game::IllegalMove, "Cell is out of bounds"
  end

  def fire_on! row, col
    cell_at(row, col).fired_on!
  end
end
