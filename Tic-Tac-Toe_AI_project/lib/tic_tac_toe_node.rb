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
