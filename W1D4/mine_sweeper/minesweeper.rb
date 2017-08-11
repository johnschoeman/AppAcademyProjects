require_relative 'board.rb'

class MineSweeper


  attr_reader :board

  def initialize(size)
    @board = Board.new_grid(size)
  end

  def play
    puts "welcome to MineSweeper"

    until lost? || won?
      board.render
      play_turn
    end
    board.render
    puts "Game Over"
  end

  def play_turn
    puts "Enter pos: "
    pos = get_pos
    handle_move(pos)
  end

  def handle_move(pos)
    tile = @board[pos]
    tile.reveal
    @board.reveal_adjacents(pos) unless tile.bomb? == true
  end

  def lost?
    if @board.any_revealed_bombs?
      puts "you lost"
      return true
    end
    false
  end

  def won?
    if @board.all_unreavealed_bombs?
      puts "you won"
      return true
    end
    false
  end

  def get_pos
    parse_pos(gets.chomp)
  end

  def parse_pos(user_input)
    user_input.split(" ").map(&:to_i)
  end


end



if __FILE__ == $PROGRAM_NAME
  game = MineSweeper.new(4)
  p game
  # game.board.render
  game.play
end
