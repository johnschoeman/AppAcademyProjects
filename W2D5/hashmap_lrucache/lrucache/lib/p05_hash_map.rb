require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket_num = bucket(key)
    @store[bucket_num].include?(key)
  end

  def set(key, val)
    if self.include?(key)
      @store[bucket(key)].update(key, val)
    else
      resize! if @count == num_buckets
      @count += 1
      @store[bucket(key)].append(key, val)
    end
  end

  def get(key)
    return nil unless self.include?(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    return nil unless self.include?(key)
    @count -= 1
    @store[bucket(key)].remove(key)
  end

  def each(&prc)
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(2 * num_buckets) { LinkedList.new }
    @count = 0
    old_store.each do |bucket|
      next if bucket.empty?
      bucket.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
