require 'byebug'
class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  # def inspect
  #   return @value.inspect if @parent.nil?
  #   { 'value' => @value, 'parent_value' => @parent.value }.inspect
  # end

  def parent=(par_node)
    old_par = @parent
    unless old_par.nil?
      old_par.children.delete(self)
    end
    @parent = par_node
    unless par_node.nil?
      par_node.children.push(self) unless par_node.children.include?(self)
    end
  end

  def add_child(child_node)
    @children.push(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a child" unless @children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    if self.value == target_value
      return self
    end
    @children.each do |child|
      search_res = child.dfs(target_value)
      next if search_res.nil?
      return search_res if search_res.value == target_value
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      curr_node = queue.shift
      if curr_node.value == target_value
        return curr_node
      else
        queue.push(*curr_node.children)
      end
    end
    nil
  end

end
