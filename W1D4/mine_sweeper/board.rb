require_relative 'tile.rb'
require 'byebug'

class Board

  def self.new_grid(size = 9)
    grid = Array.new(size) { Array.new(size) }
    board = Board.new(grid)
    board.populate_grid
    board
  end

  def initialize(grid)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def populate_grid(num_bombs = @grid.length)
    num_tiles = @grid.length * @grid[0].length
    tiles = Tile.generate_tiles(num_tiles, num_bombs, self).shuffle
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        tiles[0].pos = [row, col]
        self[[row, col]] = tiles.shift
      end
    end
  end

  def render
    @grid.each do |row|
      temp_row = ""
      row.each do |col|
        temp_row += col.to_s
      end
      puts temp_row
    end
  end

  def all_unreavealed_bombs?
    @grid.each do |row|
      row.each do |tile|
        return false if tile.bomb? == false && tile.revealed? == false
      end
    end
    true
  end

  def any_revealed_bombs?
    @grid.each do |row|
      row.each do |tile|
        return true if tile.bomb? == true && tile.revealed? == true
      end
    end
    false
  end

  def reveal_adjacents(pos)

  end

  def get_adjacents(pos)
    x, y = pos
    positions = [[x, y-1], [x, y+1], [x-1, y], [x+1, y]]
    positions.select { |position| valid_pos?(position) }
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
    pos.length == 2  &&
    pos.all? {|el| el.between?(0, @grid.length-1)}
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new_grid
  p b
  b.render
  p b.get_adjacents([1,1])
  p b.get_adjacents([0,0])
  p b.get_adjacents([5,8])
  p b.valid_pos?([3,3])
end
