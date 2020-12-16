require_relative "piece"

class Pawn < Piece

    def symbol
        raise NotImplementedError
    end

    def moves
        forward_steps + side_attacks 
    end

    private

    def at_start_row?
        row, col = @pos
        row == (@color == :white ? 6 : 1)
    end
    
    def forward_dir
        @color == :white ? -1 : 1
    end

    def forward_steps
        steps = []
        row, col = @pos
        one_step = [row + forward_dir, col]
        return steps unless @board.valid_pos?(one_step) && @board.empty?(one_step)
        steps << one_step
        
        two_step = [row + forward_dir * 2, col]
        steps << two_step if at_start_row? && @board.empty?(two_step)
        steps
    end

    def side_attacks
        # debugger
        side_moves = []
        row, col = @pos
        side_moves << [row + forward_dir, col + 1]
        side_moves << [row + forward_dir, col -1]
        side_moves.select do |side_move| 
            unless board.valid_pos?(side_move)
                next false
            end
            next false if board.empty?(side_move)

            piece = @board[side_move]
            piece && (piece.color != @color)
        end    
    end
end



