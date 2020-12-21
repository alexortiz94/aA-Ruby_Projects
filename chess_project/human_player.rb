require_relative 'player'

class HumanPlayer < Player

    def make_move(board=nil)
        while nil || !@display.cursor.selected
            @display.cursor.get_input
        end
        start_pos = @display.cursor.cursor_pos

        while nil
            puts "Where would you like to move that piece"
            print ">"
            @display.cursor.get_input until !@display.cursor.selected
        end
        end_pos = @display.cursor.cursor_pos
        @display.board.move_piece(@color, start_pos, end_pos)
    end
end