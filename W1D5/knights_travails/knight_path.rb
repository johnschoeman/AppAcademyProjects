require_relative '00_tree_node.rb'
require 'byebug'
class KnightPathFinder
  attr_reader :move_tree

  DELTAS = [[-1, 2], [-1, -2], [1,2], [1,-2], [2,1], [-2,1], [2,-1], [-2,-1]]

  def initialize(start_pos)
    @start_pos = start_pos
    @visted_posistions = [start_pos]
    @move_tree = PolyTreeNode.new(@start_pos)
  end

  def self.valid_moves(pos)
    moves = []
    DELTAS.each do |d|
      move = [d.first + pos.first, d.last + pos.last]
      moves << move if move.first.between?(0,7) && move.last.between?(0,7)
    end
    moves
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject! { |move| @visted_posistions.include?(move) }
    @visted_posistions.concat(moves)
    moves
  end

  def build_move_tree
    queue = [@move_tree]
    until queue.empty?
      curr_node = queue.shift
      next_positions = new_move_positions(curr_node.value)
      curr_node_children = []
      next_positions.each do |position|
        child = PolyTreeNode.new(position)
        child.parent = curr_node
        curr_node_children << child
      end
      queue.concat(curr_node_children)
    end
  end

  def find_path(end_pos)
    build_move_tree
    end_node = @move_tree.bfs(end_pos)
    path = trace_path_back(end_node)
    path
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    curr_node = end_node
    p curr_node.value
    until curr_node.parent.nil?
      path << curr_node.parent.value 
      curr_node = curr_node.parent
      p curr_node.value
    end
    path.reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  # p KnightPathFinder.valid_moves([0,0])
  # p KnightPathFinder.valid_moves([3,3])
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
  p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end
