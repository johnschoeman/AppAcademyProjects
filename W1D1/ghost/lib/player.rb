class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess(_,_,_)
    letters = ('a'..'z').to_a
    player_guess = ""
    loop do
      puts "#{name} Type a letter"
      player_guess = gets.chomp
      break if letters.include?(player_guess)
      puts "Not a vaild guess"
    end
    player_guess
  end

end
