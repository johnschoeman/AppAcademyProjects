require 'byebug'
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # byebug
    if @board.over?
      return true if @board.winner != evaluator && !@board.winner.nil?
      return false if @board.winner == evaluator || @board.winner.nil?
    else
      if evaluator == @next_mover_mark
        children.all? { |child| child.losing_node?(evaluator) }
      elsif evaluator == get_next_mover(@next_mover_mark)
        children.any? { |child| child.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false if @board.winner != evaluator || @board.winner.nil?
    else
      if evaluator == @next_mover_mark
        children.any? { |child| child.winning_node?(evaluator) }
      elsif evaluator == get_next_mover(@next_mover_mark)
        children.all? { |child| child.winning_node?(evaluator) }
      end
    end
  end

  def children
    children = []
    empty_positions = all_empty_positions

    empty_positions.each do |pos|
      new_board = @board.dup
      new_board[pos] = @next_mover_mark
      next_mark = get_next_mover(next_mover_mark)
      child = TicTacToeNode.new(new_board, next_mark, pos)
      children << child
    end
    return children
  end

  def get_next_mover(curr_mark)
    [:x, :o].reject { |el| el == curr_mark}.first
  end

  def all_empty_positions
    result = []
    @board.rows.each_index do |row|
      @board.rows[row].each_index do |col|
        result << [row, col] if @board.empty?([row, col])
      end
    end
    result
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  first_node = TicTacToeNode.new(b, :o)
  p first_node.children
end
