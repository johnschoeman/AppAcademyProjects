require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @tail = Node.new
    @head = Node.new

    @tail.prev = @head
    @head.next = @tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end

  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    return nil if self.empty?

    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_node = self.empty? ? @head : self.last

    @tail.prev = new_node
    prev_node.next = new_node
    new_node.next = @tail
    new_node.prev = prev_node
  end

  def update(key, val)
    return nil unless self.include?(key)

    self.each do |node|
      if node.key == key
        node.val = val
        break
      end
    end
  end

  def remove(key)
    return nil unless self.include?(key)
    node_to_rm = nil

    self.each do |node|
      if node.key == key
        node_to_rm = node
        break
      end
    end

    prev_node = node_to_rm.prev
    next_node = node_to_rm.next

    prev_node.next = next_node
    next_node.prev = prev_node
  end

  def each(&prc)
    curr_node = self.first
    until curr_node == @tail
      prc.call(curr_node)
      curr_node = curr_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
