class Battleship::Board
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
end
