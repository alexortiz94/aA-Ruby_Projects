require_relative "stepable"
require_relative "piece"

class King < Piece
    include Stepable

    def symbol
        raise NotImplementedError
    end

    protected

    def move_diffs
        [[1,0],[0,1],[1,1],[-1,-1],[-1,1],[1,-1],[-1,0],[0,-1]]
    end
end
