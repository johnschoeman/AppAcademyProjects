require_relative 'player.rb'
require_relative 'ai_player.rb'

class Game
  attr_accessor :fragment, :current_player, :players

  DICTIONARY = File.readlines('./dictionary.txt').map{|x| x.chomp}

  def initialize(*players)
    @players = players
    @current_player = players[0]
    @next_player = players[1]
    @fragment = ""
    @dictionary = DICTIONARY.dup
    @losses = Hash[@players.collect { |v| [v, 0] }]
  end

  def play_round
    until @dictionary.empty?
      take_turn(@current_player)
      next_player!
      p @fragment
      break if valid_play?(@fragment) == false
    end
    @losses[previous_player] += 1
    display_standings
  end

  def current_player
    @current_player
  end

  def previous_player
    @players[(@players.find_index(@current_player) - 1) % @players.length]
  end

  def next_player!
    @current_player = @next_player
    @next_player = @players[(@players.find_index(@current_player) + 1) % (@players.length)]
  end

  def take_turn(player)
    player_guess = player.guess(@fragment, @players.length, @dictionary)
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
    @players.each do |player|
      puts "#{player.name} : #{record(player)}"
    end
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
  player1 = AiPlayer.new("jose")
  player2 = Player.new("john")
  player3 = Player.new("p3")
  player4 = AiPlayer.new('P4')
  game = Game.new(player1, player4)
  game.run
end
