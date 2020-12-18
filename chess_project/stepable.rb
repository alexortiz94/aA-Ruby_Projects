require 'byebug'

module Stepable

    def moves
        moves = []
        # debugger
        move_diffs.each do |d_row, d_col|
            # debugger
            cur_row, cur_col = @pos
            # debugger 
            cur_row, cur_col = cur_row + d_row, cur_col + d_col
            new_pos = [cur_row, cur_col]
            # debugger
            next if !@board.valid_pos?(new_pos)
            moves << new_pos if @board.empty?(new_pos) || @board[new_pos].color != @color
        end
        moves
    end

    def move_diffs
        raise NotImplementedError
    end
end

            