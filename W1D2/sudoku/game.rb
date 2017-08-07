require_relative 'board.rb'

class Game
  def initialize(board, player)
    @board = board
    @player = player
  end

  def play
    until @board.solved?
      @board.render
      pos, number = prompt
      update_board(pos, number)
    end
    puts "Game solved!"
  end

  def prompt
    puts "Enter your position"
    position = gets
    pos = position.split(",").map { |el| el.to_i }
    puts "Enter a number"
    number = gets.chomp
    [pos, number]
  end

  def update_board(pos, number)
    @board.update_value(pos, number)
  end
end

if __FILE__ == $PROGRAM_NAME
   b = Board.from_file("./sudoku1.txt")
  # b.render

  #b = Board.from_file("./sudoku1-solved.txt")
  g = Game.new(b,"")
  g.play
end
