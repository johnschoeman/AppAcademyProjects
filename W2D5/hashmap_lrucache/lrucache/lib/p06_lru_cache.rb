require 'byebug'
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      res = node.val
      update_node!(node)
    else
      res = calc!(key)
    end
    res
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last
    eject! if self.count > @max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    key, val = node.key, node.val
    @store.remove(key)
    @store.append(key, val)
    @map[key] = @store.last
  end

  def eject!
    node = @store.first
    key = node.key
    @store.remove(key)
    @map.delete(key)
  end

end
