class Card
  SUITS = [:c, :s, :h, :d]

  attr_reader :suit, :value

  def initialize(suit, value)
    raise 'Value out of range' unless value.between?(0,12)
    raise 'Invalid suit' unless SUITS.include?(suit)
    @suit = suit
    @value = value
  end

  def self.standard_cards
    cards = []
    SUITS.each do |suit|
      (0..12).each do |val|
        cards << Card.new(suit,val)
      end
    end
    cards
  end

  def inspect
    "#{@suit} : #{@value}"
  end

end
