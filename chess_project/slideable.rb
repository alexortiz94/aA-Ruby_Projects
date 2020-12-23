module Slideable
    HORIZONTAL_DIRS = [[0,1],[0,-1],[1,0],[-1,0]].freeze
    DIAGONAL_DIRS = [[1,1],[-1,1],[1,-1],[-1,-1]].freeze

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diaganol_dirs
        DIAGONAL_DIRS
    end

    def moves
        # debugger
        moves = []
        move_dirs.each do |d_row, d_col|
            moves.concat(grow_unblocked_moves_in_dir(d_row, d_col))
        end
         
        moves
    end

    private
    
    def move_dirs
        raise NotImplementedError
    end

    def grow_unblocked_moves_in_dir(d_row, d_col)
        moves = []
        start_pos = @pos.dup
        cur_row, cur_col = start_pos
        loop do
            # debugger
            cur_row, cur_col = cur_row + d_row, cur_col + d_col
            new_pos = [cur_row, cur_col]
            break unless @board.valid_pos?(new_pos)
            # debugger
            if @board.empty?(new_pos)
                moves << new_pos
            else 
                moves << new_pos if @board[new_pos].color != @color
                break
            end
        end
        moves
    end




end




