class Player
  def initialize(name)
    @name = name
  end

  def prompt(_)
    puts "Enter guess"
    user_guess = gets
    user_guess.split(",").map { |e| e.to_i }
  end
end
