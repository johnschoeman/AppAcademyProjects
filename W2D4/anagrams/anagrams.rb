def first_anagram?(str1, str2) # -> O(n!)
  pos_anagrams = str1.chars.permutation.to_a
  pos_anagrams.include?(str2.chars)
end

def second_anagram?(str1, str2) # -> O(n^2)
  str1_chars = str1.chars
  str2_chars = str2.chars
  str1_chars.each_index do |i|
    str2_chars.each_index do |j|
      if str1_chars[i] == str2_chars[j]
        str1_chars[i] = ""
        str2_chars[j] = ""
      end
    end
  end
  return true if str1_chars.join("") == "" && str2_chars.join("") == ""
  false
end

def third_anagram?(str1, str2) # -> O(nlogn)
  str1.chars.sort == str2.chars.sort
end

def fourth_anagram?(str1, str2) # -> O(n)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  str1.chars.each do |ch|
    hash1[ch] += 1
  end
  str2.chars.each do |ch|
    hash2[ch] += 1
  end
  hash1 == hash2
end

def bonus_anagram?(str1, str2)
  hash = Hash.new(0)
  num_letters = 0
  str1.chars.each do |ch|
    hash[ch] += 1
  end
  num_letters = hash.keys.length
  str2.chars.each do |ch|
    hash[ch] += 1
  end
  return false if hash.keys.length > num_letters
  return true if hash.values.all? { |el| el.even? }
end

def best_anagram?(str1, str2) # -> O(n) S(1)
  res = 0
  str1.each_char do |ch|
    res ^= ch.ord
  end
  str2.each_char do |ch|
    res ^= ch.ord
  end
  res == 0
end

def prime_anagram?(str1, str2)
  h = { "a" => 2, "b" => 3, "c" => 5, "d" => 7, "e" => 11, "f" => 13, "g" => 17,
        "h" => 19, "i" => 23, "j" => 29, "k" => 31, "l" => 37, "m" => 41, "n" => 43,
        "o" => 47, "p" => 53, "q" => 59, "r" => 61, "s" => 67, "t" => 71, "u" => 73,
        "v" => 79, "w" => 83, "x" => 89, "y" => 97, "z" => 101 }

  p1 = str1.chars.map { |ch| h[ch] }.inject(:*)
  p2 = str2.chars.map { |ch| h[ch] }.inject(:*)

  p1 == p2
end


if __FILE__ == $PROGRAM_NAME
  str1 = "gizmo"
  str2 = "elvis"
  str3 = "lives"

  # p first_anagram?(str1,str2)
  # p first_anagram?(str2,str3)
  #
  # p second_anagram?(str1,str2)
  # p second_anagram?(str2,str3)
  #
  # p third_anagram?(str1,str2)
  # p third_anagram?(str2,str3)
  #
  # p fourth_anagram?(str1,str2)
  # p fourth_anagram?(str2,str3)
  #
  # p best_anagram?(str1,str2)
  # p best_anagram?(str2,str3)
  #
  # p prime_anagram?(str1,str2)
  # p prime_anagram?(str2,str3)

  # p hash[15] == hash[20]
end
