require "byebug"
def brute_force_two_sum?(arr, target_sum) # -> O(n^2)
  (0...arr.length - 1).each do |i|
    (i + 1 .. arr.length - 1).each do |j|
      return true if arr[i] + arr[j] == target_sum
    end
  end
  false
end

def sorting_two_sum?(arr, target_sum) # -> O(n log n)
  arr.sort!
  arr.length.times do
    el = arr.shift
    diff = target_sum - el
    return true if arr.bsearch {|x| diff - x }
  end
  false
end

def hash_two_sum?(arr, target_sum) # -> O(n)
  h = {}
  arr.each_with_index do |el, i|
    h[target_sum - el] = i
  end
  arr.each_with_index do |el, i|
    return true if h.has_key?(el) && h[el] != i
  end
  false
end




if __FILE__ == $PROGRAM_NAME
  arr = [0, 1, 5, 7]
  arr2 = [0, 2, 4, 8]
  arr3 = [1729, 561, 1105, 6601]

  # p brute_force_two_sum?(arr, 6) # => should be true
  # p brute_force_two_sum?(arr, 10) # => should be false
  p sorting_two_sum?(arr, 6) # => should be true
  p sorting_two_sum?(arr, 10) # => should be false

  # p hash_two_sum?(arr, 6) # => should be true
  # p hash_two_sum?(arr, 10) # => should be false
  # p hash_two_sum?(arr2, 10) # => should be true
  # p hash_two_sum?(arr2, 16) # => should be false
  # p hash_two_sum?(arr3, 1666) # => should be true
  # p hash_two_sum?(arr3, 1973) # => should be false
end
