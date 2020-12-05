require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if self.board.over? && (self.board.winner == evaluator || nil) 
    return true if self.board.over? && (self.board.winner != evaluator || nil)
    child_nodes = self.children
    if self.next_mover_mark == evaluator
      result = child_nodes.all? { |child_node| child_node.losing_node?(evaluator) }
    else
      result = child_nodes.any? { |child_node| child_node.losing_node?(evaluator) }
    end
    result
  end

  def winning_node?(evaluator)
    return true if self.board.over? && (self.board.winner == evaluator)
    return false if self.board.over? && (self.board.winner != evaluator)
    child_nodes = self.children
    if self.next_mover_mark == evaluator
      result = child_nodes.any? { |child_node| child_node.winning_node?(evaluator) }
    else
      result = child_nodes.all? { |child_node| child_node.winning_node?(evaluator) }
    end
    result
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_nodes = []
    self.empty_positions.each do |pos|
      new_board = @board.dup
      new_board[pos] = @next_mover_mark
      mover_mark = nil
      @next_mover_mark == :x ? mover_mark = :o : mover_mark = :x
      child_node = TicTacToeNode.new(new_board, mover_mark, pos)
      child_nodes << child_node
    end
    child_nodes
  end

  def empty_positions
    empty_positions = []
    childen = []
    row = 0
    while row <= 2
      (0..2).each do |col|
        position = [row, col]
        empty_positions << position if @board.empty?(position)
      end
      row += 1
    end
    empty_positions
  end

end
