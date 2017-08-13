class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise("Out of bounds") unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return nil if self.include?(num)
    self[num] << num
  end

  def remove(num)
    return nil unless self.include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_num = num % num_buckets
    @store[bucket_num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return nil if self.include?(num)
    resize! if @count == num_buckets
    @count += 1
    self[num] << num
  end

  def remove(num)
    return nil unless self.include?(num)
    @count -= 1
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_num = num % num_buckets
    @store[bucket_num]
  end

  def num_buckets
    @store.length
  end

  # def resize!
  #   new_store = Array.new(2 * @store.length) { Array.new }
  #   @store.each do |bucket|
  #     bucket.each do |el|
  #       new_bucket_num = el % new_store.length
  #       new_store[new_bucket_num] << el
  #     end
  #   end
  #   @store = new_store
  # end

  def resize!
    old_store = @store.dup.flatten
    @store = Array.new(2 * @store.length) { Array.new }
    @count = 0
    old_store.each do |el|
      self.insert(el)
    end
  end

end
