require_relative 'tile.rb'

class Board
  def initialize(grid_of_strings)
    @grid = tilize(grid_of_strings)
  end

  def self.from_file(text_file)
    lines = File.readlines(text_file).map { |line| line.chomp }
    grid_of_strings = []
    lines.each do |line|
      grid_of_strings << line.split("")
    end
    Board.new(grid_of_strings)
  end

  def tilize(grid_of_strings)
    grid = Array.new(9) {Array.new(9)}
    grid_of_strings.each_index do |row|
      grid_of_strings[row].each_index do |col|
        value = grid_of_strings[row][col]
        boolean_given = value == "0" ? false : true
        grid[row][col] = Tile.new(value,boolean_given)
      end
    end
    grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def update_value(pos, value)
    unless valid_move?(pos)
      puts "Not valid move!"
      return
    end
    self[pos] = Tile.new(value, false)
  end

  def valid_move?(pos)
    !self[pos].given
  end

  def render
    @grid.each do |row|
      temp_row = []
      row.each do |tile|
        temp_row << tile.to_s
      end
      puts temp_row.join(" ")
    end
  end

  def solved?
    return false unless cols_solved?
    return false unless rows_solved?
    return false unless squares_solved?
    true
  end

  def rows_solved?
    nums = []
    @grid.each do |row|
      nums = []
      row.each do |tile|
        nums << tile.value.to_i
      end
      return false unless nums.sort == (1..9).to_a
    end
    true
  end


  def cols_solved?
    transposed_grid = @grid.transpose
    nums = []
    transposed_grid.each do |col|
      nums = []
      col.each do |tile|
        nums << tile.value.to_i
      end
      return false unless nums.sort == (1..9).to_a
    end
    true
  end


  def squares_solved?
    starting_pos = [[0,0],[0,3],[0,6],[3,0],[3,3],[6,3],[6,0],[6,3],[6,6]]
    starting_pos.each do |pos|
      square = build_square(pos)
      return false unless square_solved?(square)
    end
    true
  end

  def build_square(pos)
    start_row, start_col = pos
    subsquare = Array.new(3) { Array.new (3) }
    0.upto(2) do |row|
      0.upto(2) do |col|
        subsquare[row][col] = @grid[start_row + row][start_col + col]
      end
    end
    subsquare
  end

  def square_solved?(square)
    nums = []
    square.each do |row|
      row.each do |tile|
        nums << tile.value.to_i
      end
    end
    return false unless nums.sort == (1..9).to_a
    true
  end

end

if __FILE__ == $PROGRAM_NAME
   b = Board.from_file("./sudoku1.txt")
  # b.render

  #b = Board.from_file("./sudoku1-solved.txt")
  b.render
  p b.solved?
end
