require_relative 'min_max_stack_queue'
require 'byebug'

def naive_window_range(arr, w) # -> O(n^2)
  current_max_range = 0
  (0..arr.length - w).each do |i|
    temp_window = arr[i..i+w-1]
    min,max = temp_window.min, temp_window.max
    diff = max - min
    current_max_range = diff if current_max_range < diff
  end
  current_max_range
end

def window_range(arr, w)
  queue = MinMaxStackQueue.new
  current_max_range = nil
  w.times do |i|
    queue.enqueue(arr[i])
  end
  (w..arr.length - 1).each do |i|
    min = queue.min
    max = queue.max
    diff = max - min
    current_max_range = diff if current_max_range.nil?
    current_max_range = diff if current_max_range < diff
    queue.dequeue
    queue.enqueue(arr[i])
  end
  current_max_range
end

if __FILE__ == $PROGRAM_NAME
  p window_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  p window_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  p window_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  p window_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
end
