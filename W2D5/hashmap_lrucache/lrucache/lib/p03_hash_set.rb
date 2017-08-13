require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return nil if self.include?(key)
    resize! if @count == num_buckets
    @count += 1
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return nil unless self.include?(key)
    @count -= 1
    self[key].delete(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    bucket_num = key.hash % num_buckets
    @store[bucket_num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup.flatten
    @store = Array.new(2 * num_buckets) { Array.new }
    @count = 0
    old_store.each do |el|
      self.insert(el)
    end
  end
end
