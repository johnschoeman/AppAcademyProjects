class MinMaxStackQueue
  def initialize
    @stack_push = MyStack.new
    @stack_shift = MyStack.new
  end

  def enqueue(el)
    @stack_push.push(el)
  end

  def max
    [@stack_push.max, @stack_shift.max].compact.max
  end

  def min
    byebug
    [@stack_push.min, @stack_shift.min].compact.min
  end

  def dequeue
    if @stack_shift.empty?
      until @stack_push.empty?
        el = @stack_push.pop
        @stack_shift.push(el) unless el.nil?
      end
    end
    @stack_shift.pop
  end

  def size
    @stack_push.size + @stack_shift.size
  end

  def empty?
    @stack_push.empty? && @stack_shift.empty?
  end

end

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
  end

  def max
    prev_obj = peek
    return nil if prev_obj.nil?
    prev_obj[:max]
  end

  def min
    prev_obj = peek
    return nil if prev_obj.nil?
    prev_obj[:min]
  end

  def pop
    obj = @store.pop
    obj[:el]
  end

  def push(el)
    obj = { el: el }

    prev_obj = @store.last

    if prev_obj.nil?
      prev_max = el
      prev_min = el
    else
      prev_max = prev_obj[:max]
      prev_min = prev_obj[:min]
    end

    max = prev_max
    min = prev_min

    max = el if el > prev_max
    min = el if el < prev_min
    obj[:max] = max
    obj[:min] = min

    @store.push(obj)
  end

  def peek
    @store.last
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end
end
