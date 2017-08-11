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
    [@stack_push.min, @stack_shift.min].compact.min
  end

  def dequeue
    swap if @stack_shift.empty?
    @stack_shift.pop
  end

  def size
    @stack_push.size + @stack_shift.size
  end

  def empty?
    @stack_push.empty? && @stack_shift.empty?
  end

  private

  def swap
    until @stack_push.empty?
      el = @stack_push.pop
      @stack_shift.push(el) unless el.nil?
    end
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
    return nil if empty?
    peek[:max]
  end

  def min
    return nil if empty?
    peek[:min]
  end

  def pop
    obj = @store.pop
    obj[:el]
  end

  def push(el)
    obj = { el: el, min: curr_min(el), max: curr_max(el) }
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

  private

  def curr_min(val)
    if @store.empty?
      val
    elsif @store.last[:min] < val
      @store.last[:min]
    else
      val
    end
  end

  def curr_max(val)
    if @store.empty?
      val
    elsif @store.last[:max] > val
      @store.last[:max]
    else
      val
    end
  end
end
