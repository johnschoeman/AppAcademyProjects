require_relative 'card.rb'

class Board
  attr_accessor :grid
  def initialize(grid=nil)
    @grid ||= Array.new(4) {Array.new(4)}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def populate
    num_pairs = (@grid[0].length*@grid.length)/2
    cards = []
    num_pairs.times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end
    cards = cards.shuffle
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        self[[row,col]] = cards.pop
      end
    end
  end

  def render
    @grid.each_index do |row|
      temp_row = []
      @grid[row].each_index do |col|
        temp_row << self[[row,col]].to_s
      end
      puts temp_row.join(" ")
    end
  end

  def won?
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        return false unless self[[row,col]].face_up
      end
    end
    true
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal
  end

end
