require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    empty_positions = all_empty_positions
    empty_positions.each do |pos|
      new_board = @board.dup
      new_board[pos] = @next_mover_mark
      #next_mark = get_next_mover(next_mover_mark)
      next_mark = "X"
      child = TicTacToeNode.new(new_board, next_mark, @next_mover_mark)
      children << child
    end
    return children
  end

  def get_next_mover(curr_mark)

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
  b=Board.new
  first_node = TicTacToeNode.new(b, "O", "X")
  p first_node.children
end
