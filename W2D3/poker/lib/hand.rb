class Hand

  attr_reader :hand

  def initialize(cards = [])
    @hand = cards
  end



  def rank # -> Integer
    raise "Need 5 card hand to calculate rank" unless @hand.length == 5

    return 3 if is_straight?
    return 2 if is_flush?
    return 1 if is_pair?
    0
  end

  def receive_card(card)
    raise "Can't add to full hand" unless @hand.length.between?(0,4)
    @hand << card
  end


  def <=>(their_hand) # -> Hand
    my_rank = self.rank
    their_rank = their_hand.rank

    if my_rank == their_rank
      return Hand.highest_card(self, their_hand) # -> Hand with highest card
    end

    my_rank > their_rank ? self : their_hand
  end

  private

  def self.highest_card(first_hand, second_hand)
    first_values = first_hand.hand.map { |card| card.value }
    second_values = second_hand.hand.map { |card| card.value }

    max_first = first_values.max
    max_second = second_values.max

    if max_second > max_first
      return second_hand
    elsif max_second < max_first
      return first_hand
    else
      return "draw"
    end
  end

  def is_flush?
    suit = @hand.first.suit
    self.hand.all? { |card| card.suit == suit }
  end

  def is_pair?
    h = Hash.new(0)
    self.hand.each do |card|
      h[card.value] += 1
    end
    h.values.any? { |val| val == 2 }
  end

  def is_straight?
    values = []
    self.hand.each do |card|
      values << card.value
    end
    min, max = values.minmax
    values.sort == (min..max).to_a
  end

end
