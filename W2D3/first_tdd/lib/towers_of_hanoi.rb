class TowersOfHanoi

  attr_reader :discs

  def initialize
    @discs = [[1,2,3],
              [],
              []]
  end

  def move_disc(start_tower, end_tower)
    raise "Please pick disc on tower" unless start_tower.between?(0,2)
    raise "Can't move disc off of towers" unless end_tower.between?(0,2)
    if !@discs[end_tower].empty? && @discs[start_tower].first > @discs[end_tower].first
      raise "Can't move larger disc onto smaller disc"
    end

    @discs[end_tower].unshift(@discs[start_tower].shift)
  end

  def won?
    @discs[1].count == 3 || @discs[2].count == 3
  end

  def render
    puts "#{@discs[0][0].to_s} #{@discs[1][0].to_s} #{@discs[2][0].to_s}"
    puts "#{@discs[0][1].to_s} #{@discs[1][1].to_s} #{@discs[2][1].to_s}"
    puts "#{@discs[0][2].to_s} #{@discs[1][2].to_s} #{@discs[2][2].to_s}"
  end

  def play
    puts "Welcome to the Jungle"
    until won?
      system("clear")
      render
      puts "make move: ex: 0 1"
      move = gets.chomp.split(" ").map(&:to_i)
      move_disc(*move)
    end
    puts "You win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  g = TowersOfHanoi.new
  # g.move_disc(0,2)
  # g.move_disc(0,1)
  g.play
end
