class Array
  def my_uniq
    self.uniq
  end

  def two_sum
    res = []

    (0...length-1).each do |i|
      (i+1..length-1).each do |j|
        res.push([i,j]) if self[i] + self[j] == 0
      end
    end
    res
  end

  def my_transpose
    self.transpose
  end

end

def stock_picker(arr)
  curr_prof_days = nil
  largest_prof = -9000000

  (0...arr.length-1).each do |start_pos|
    (start_pos+1..arr.length-1).each do |end_pos|
      curr_prof = 0
      # check_prof = arr[start_pos] + arr[end_pos]
      curr_prof -= arr[start_pos]
      curr_prof += arr[end_pos]

      if curr_prof > largest_prof && curr_prof > 0
        curr_prof_days = [start_pos, end_pos]
        largest_prof = curr_prof
      end
    end
  end
  curr_prof_days
end
