class ComputerPlayer
  def initialize(name)
    @name = name
    @known_cards = {}
    @matched_cards = []
  end

  def prompt(previous_guess)
    if previous_guess == nil
      return prompt_first_guess
    else
      return prompt_second_guess
    end
  end

  def prompt_first_guess
    puts "in first guess"
    p @known_cards
    p @matched_cards

    if @matched_cards.empty?
      guess = random_pick

    else
      guess = @matched_cards[0]
    end
    return guess
  end

  def has_match?()

  end

  def prompt_second_guess
    puts "in second guess"
    p @known_cards
    p @matched_cards
    if @matched_cards.empty?
      guess = random_pick
    else
      guess = @matched_cards[1]
      @matched_cards = []
    end
    return guess
  end

  def received_revealed_card(pos, value)
    puts "HI"
    @known_cards.each do |k, v|
      # p k
      # p v
      # p pos
      # p value
      # p @match
      if v == value && pos != k
        @matched_cards = [k, pos]
      end
    end
    @known_cards[pos] = value
  end

  def received_match(pos1, pos2)
    @matched_cards << [pos1, pos2]
  end

  def random_pick
    r = 0
    c = 0
    loop do
      r = rand(4)
      c = rand(4)
      break unless @known_cards.include?([r, c])
    end
    [r, c]
  end
end
