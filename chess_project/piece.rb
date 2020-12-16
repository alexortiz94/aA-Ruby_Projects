require_relative "board"

class Piece

    attr_reader :color, :board
    attr_accessor :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos

        board.add_piece(self, pos)
    end

    def inspect
        "#{self.color} #{self.to_s}:#{self.pos}"
    end

    def to_s
        self.class.to_s
    end

    def empty?
        false
    end

    def symbol
        raise NotImplementedError
    end

    # def valid_moves
    #     moves.reject {|end_pos| move_into_check?(end_pos) }
    # end

    private
    
    # def move_into_check?(end_pos)
    #     test_board = @board.dup
    #     test_board.move_piece!(self.pos, end_pos)
    #     test_board.in_check?(self.color)
    # end    

end