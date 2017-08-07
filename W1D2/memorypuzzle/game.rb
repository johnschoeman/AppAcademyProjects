require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'player.rb'
require_relative 'ai.rb'

class Game
  def initialize(player)
    @board = Board.new
    @previous_guess = nil
    @player = player
  end

  def play
    @board.populate
    until over?
      system("clear")
      @board.render
      guessed_pos = @player.prompt(@previous_guess)
      make_guess(guessed_pos)
    end
    @board.render
    puts "you won!"
  end

  def over?
    @board.won?
  end

  def make_guess(pos)
    @board.reveal(pos)
    @player.received_revealed_card(pos,@board[pos].face_value)
    if @previous_guess == nil
      make_first_guess(pos)
    else
      make_second_guess(pos)
    end
  end

  def make_first_guess(pos)
    @previous_guess = pos
  end

  def make_second_guess(pos)
    if @board[@previous_guess] == @board[pos]
      @previous_guess = nil
    else
      @board.render
      sleep(1)
      @board[@previous_guess].hide
      @board[pos].hide
      @previous_guess = nil
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(ComputerPlayer.new("name"))
  g.play
end
