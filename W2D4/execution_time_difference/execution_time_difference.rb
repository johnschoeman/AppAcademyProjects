def my_min(list) # -> O(n^2)
  smallest = list.first
  (0...list.length-1).each do |i|
    (i+1..list.length-1).each do |j|
      if list[i] < list[j]
        smallest = list[i]
      else
        smallest = list[j]
      end
    end
  end
  smallest
end

def iter_min(list) # -> O(n)
  smallest = list.first
  list.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

def largest_contiguous_subsum(list) # -> O(n^2)
  largest = []
  sub_arrs = []
  # (1...list.length).each do |i|
  #   list.each_cons(i) do |subset|
  #     sub_arrs << subset
  #   end
  # end
  (0..list.length - 1).each do |i|
    (i..list.length - 1).each do |j|
      sub_arr = list[i..j]
      sub_arrs << sub_arr
    end
  end

  largest = sub_arrs.map do |arr|
    arr.reduce(:+)
  end

  largest.max
end

def better_largest_contiguous_subsum(list) # ->O(n)
  curr_sum = 0
  prev_sum = 0

  list.each do |n|
    if n >= 0
      curr_sum += n
    else
      if curr_sum > prev_sum
        prev_sum = curr_sum
      end
      curr_sum = 0
    end
  end
  if curr_sum > prev_sum
    prev_sum = curr_sum
  end
  prev_sum
end

if __FILE__ == $PROGRAM_NAME
  list = [1,2,3,-1,4,5,-1]

  p better_largest_contiguous_subsum(list)
end
