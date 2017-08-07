require 'colorize'

class Tile
  attr_reader :given, :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    if @given == true
      @value.colorize(:black)
    else
      @value.colorize(:red)
    end
  end
end

if __FILE__==$PROGRAM_NAME
  t = Tile.new("9",true)
  s = Tile.new("7",false)
  puts t.to_s
  puts s.to_s
end
