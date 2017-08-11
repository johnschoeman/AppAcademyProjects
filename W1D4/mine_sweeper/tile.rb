class Tile
  attr_accessor :pos

  def initialize(bool_bomb, board)
    @bool_bomb = bool_bomb
    @board = board
    @bool_revealed = false
    @neighbor_bomb_count = 0
    @pos = nil
  end

  def self.generate_tiles(num_tiles, num_bombs, board)
    tiles = []
    num_bombs.times { tiles << Tile.new(true, board) }
    (num_tiles - num_bombs).times { tiles << Tile.new(false, board) }
    tiles
  end

  def neighbors

  end

  def neighbor_bomb_count

  end

  def revealed?
    @bool_revealed
  end

  def bomb?
    @bool_bomb
  end

  def reveal
    @bool_revealed = true
  end

  def hide
    @bool_revealed = false
  end

  def to_s
    unless @bool_revealed
      return " * "
    end

    if @bool_bomb
      " X "
    else
      " _ "
    end
  end

  def inspect
    # if @bool_bomb
    #   "X"
    # else
    #   "-"
    # end
    "#{@bool_bomb} - #{@pos}"
  end

end

if __FILE__ == $PROGRAM_NAME
  p Tile.generate_tiles(4, 2)
end
