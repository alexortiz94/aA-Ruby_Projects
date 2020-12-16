require_relative "pieces"
require "byebug"

class Board
    attr_reader :rows

    def initialize(fill_grid=true)
        @null_piece = NullPiece.instance
        @rows = Array.new(8) {Array.new(8,@null_piece)}
        
        make_starting_grid(fill_grid)
    end

    def [](pos)
        row, col = *pos
        @rows[row][col]
    end

    def []=(pos, val)
        row, col = *pos
        @rows[row][col] = val
    end

    def empty?(pos)
        self[pos].empty?
    end

    def add_piece(piece, pos)
        raise "that position is not empty" unless self[pos].empty?
        self[pos] = piece
    end

    def move_piece(turn_color, start_pos, end_pos)
        # debugger
        piece = self[start_pos]
        raise ArgumentError.new "There is no piece at start_pos" if piece.empty?
        raise ArgumentError.new "That piece cannot move there" unless piece.moves.include?(end_pos)
        # raise ArgumentError.new "You cannot move into check" unless piece.valid_moves.include?(end_pos)
        raise ArgumentError.new "That piece is not your color" if piece.color != turn_color
        # debugger
        self[start_pos] = @null_piece
        self[end_pos] = piece
        piece.pos = end_pos
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) } 
    end

    def dup
        @rows.dup.map { |row| row.dup }
    end

    private

    def fill_back_row(color)
        back_row_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        row = color == :white ? 7 : 0
        back_row_pieces.each_with_index do |piece_class, col|
            piece_class.new(color, self, [row, col])
        end
    end

    def fill_pawns_row(color)
        row = color == :white ? 6 : 1
        8.times {|col| Pawn.new(color, self, [row, col])}
    end

    def make_starting_grid(fill_grid)
        return unless fill_grid
        [:white, :black].each do |color|
            fill_back_row(color)
            fill_pawns_row(color)
        end
    end
end


if $PROGRAM_NAME == __FILE__
    b1 = Board.new
    p b1
    b1.move_piece(:white,[6,1],[4,1])
    p b1
end
