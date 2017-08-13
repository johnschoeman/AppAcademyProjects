class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i >= 0
      @store[i]
    elsif i < 0
      idx = @count + i
      return nil if idx < 0
      @store[idx]
    end
  end

  def []=(i, val)
    if i >= 0 && i < @count
      @store[i] = val
    elsif i > @count
      until @count = i + 1
        self.push(nil)
      end
      @store[i] = val
      self.push(nil)
    elsif i < 0
      idx = @count + i
      return nil if idx < 0
      @store[idx] = val
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...@store.length).each do |i|
      return true if @store[i] == val
    end
    false
  end

  def push(val)
    resize! if @count >= @store.length
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count >= @store.length

    (@count - 1).downto(0).each do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
    @count += 1
    resize! if @count >= @store.length
  end

  def pop
    return nil if @count == 0
    @count -= 1
    res = @store[@count]
    @store[@count] = nil
    res
  end

  def shift
    return nil if @count == 0
    res = @store[0]
    (0...@count).each do |i|
      @store[i] = @store[i+1]
    end
    @count -= 1
    res
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    (0...@count).each do |i|
      prc.call(@store[i])
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    (0...@count).each do |i|
      return false unless self[i] == other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(2 * @store.length)
    (0...@store.length).each do |i|
      new_store[i] = @store[i]
    end
    @store = new_store
  end
end
