class AiPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess(fragment, num_players, dictionary)
    if dictionary.empty?
      return ('a'..'z').to_a[rand(26)]
    end

    letters = ('a'..'z').to_a
    dictionary.each do |word|
      if word.length == fragment.length + 1
        letters.delete(word[-1])
      end
    end

    (letters.length-1).downto(0) do |i|
      dummy_word = fragment + letters[i]
      unless dictionary.any? { |word| word.start_with?(dummy_word) }
        letters.delete_at(i)
      end
    end

    temp_dict = dictionary.reject do |word|
      word.length > fragment.lenght + num_players
    end

    return ('a'..'z').to_a[rand(26)] if letters.empty?
    letters.to_a[rand(letters.length)]
  end

end
