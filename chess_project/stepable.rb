module Stepable

    def moves
        moves = []

        move_diffs.each do |d_row, d_col|
            start_pos = @pos.dup
            start_pos = cur_row, cur_col
            cur_row, cur_col = cur_row + d_row, cur_col + d_col
            new_pos = [cur_row, cur_col]
            moves << new_pos if @board[new_pos].empty? || @board[new_pos].color != @color
        end
        moves
    end

    def move_diffs
        raise NotImplementedError
    end
end

            