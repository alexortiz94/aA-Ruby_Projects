require_relative 'board'
require_relative 'cursor'
require 'colorize'
require 'byebug'

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        disp = board.rows.map.with_index do |row, idx|
            color_seq = idx.even? ? %i[light_red light_black light_red light_black light_red light_black light_red light_black] : %i[light_black light_red light_black light_red light_black light_red light_black light_red]
            row.map.with_index do |piece, i|
                if [idx, i] == @cursor.cursor_pos
                    @cursor.selected ? " #{piece.symbol} ".colorize(:color => piece.color, :background => :blue) : " #{piece.symbol} ".colorize(:color => piece.color, :background => :light_blue)
                else 
                    " #{piece.symbol} ".colorize(:color => piece.color, :background => color_seq[i])
                end
            end.join
        end
        disp.each {|row| print row + "\n"}
    end

    def test_cursor
        loop do 
            self.render
            @cursor.get_input
        end
    end
end
    
if $PROGRAM_NAME == __FILE__
    b1 = Board.new
    disp = Display.new(b1)
    disp.test_cursor
end

