require_relative 'player.rb'

class Game
  attr_accessor :fragment, :current_player

  DICTIONARY = File.readlines('./dictionary.txt').map{|x| x.chomp}

  def initialize(player1, player2)
    @current_player = player1
    @next_player = player2
    @fragment = ""
    @dictionary = DICTIONARY.dup
    @losses = {player1 => 0, player2 => 0}
  end

  def play_round
    until @dictionary.empty?
      take_turn(@current_player)
      next_player!
      break if valid_play?(@fragment) == false
    end
    @losses[@next_player] += 1
    display_standings
  end

  def current_player
    @current_player
  end

  def previous_player
    @next_player
  end

  def next_player!
    @current_player, @next_player = @next_player, @current_player
  end

  def take_turn(player)
    player_guess = player.guess
    @fragment += player_guess
  end

  def valid_play?(string)
    # raise "Word in Dictionary" if @dictionary.include?(@fragment)
    # @dictionary = @dictionary.select { |word| word if word.start_with?(@fragment) }
    # raise "Empty dictionary" if @dictionary.empty?

    if @dictionary.include?(@fragment)
      puts "Word in Dictionary"
      return false
    end
    @dictionary = @dictionary.select { |word| word if word.start_with?(@fragment) }
    if @dictionary.empty?
      puts "Empty dictionary"
      return false
    end
    true
  end

  def record(player)
    " GHOST"[0..@losses[player]]
  end

  def display_standings
    puts "#{@current_player.name} : #{record(@current_player)}"
    puts "#{@next_player.name} : #{record(@next_player)}"
  end

  def run
    until @losses[@next_player] == 5
      play_round
      @fragment = ""
      @dictionary = DICTIONARY
    end
    puts "#{@next_player.name} loses"
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("jose")
  player2 = Player.new("john")
  game = Game.new(player1, player2)
  game.run
end
