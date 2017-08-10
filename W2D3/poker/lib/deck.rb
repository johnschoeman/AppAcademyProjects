require_relative 'card'

class Deck

  attr_reader :deck

  def initialize(cards = Card.standard_cards)
    @deck = cards
  end

  def take_top_card
    @deck.shift
  end

  def shuffle!
    @deck.shuffle!
  end

end
