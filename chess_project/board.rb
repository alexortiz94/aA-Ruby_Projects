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
        if piece.empty?
            raise "There is no piece at start_pos" 
        elsif !piece.moves.include?(end_pos) 
            raise "That piece cannot move there" 
        elsif piece.color != turn_color   
            raise "That piece is not your color"
        elsif !piece.valid_moves.include?(end_pos)
            raise "You cannot move yourself into check"
        end 
        # debugger
        move_piece!(start_pos, end_pos)
    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        raise "That piece cannot move like that" unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        self[start_pos] = @null_piece
        piece.pos = end_pos

        nil
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end

    def dup
        dup_board = Board.new(false)

        pieces.each { |piece| piece.class.new(piece.color, dup_board, piece.pos) }

        dup_board   
    end

    def checkmate?(color)
        color_pieces = pieces.select { |piece| piece.color == color }
        color_pieces.all? { |piece| piece.valid_moves.empty? }
    end
            

    def in_check?(color)
        king_pos = find_king(color)
        opps_pieces = pieces.reject { |piece| piece.color == color }
        opps_pieces.any? { |piece| piece.moves.include?(king_pos)}
    end

    def find_king(color)
        @rows.flatten.each { |piece| return piece.pos if piece.color == color && piece.to_s == "King"}
    end

    def pieces
        rows.flatten.reject(&:empty?)
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
    b1.move_piece(:white, [6,5],[5,5])
    b1.move_piece(:black, [1,4],[3,4])
    b1.move_piece(:white, [6,6],[4,6])
    b1.move_piece(:black, [0,3],[4,7])
    p b1.in_check?(:white)
    p b1.checkmate?(:white)
    
    
end
