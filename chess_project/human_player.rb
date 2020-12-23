require_relative 'player'

class HumanPlayer < Player

    def make_move(board=nil)
        while nil || !@display.cursor.selected
            system("clear")
            puts "Which piece would you like to move?"
            @display.render
            @display.cursor.get_input
        end
        start_pos = @display.cursor.cursor_pos

        until !@display.cursor.selected
            system("clear")
            puts "Where would you like to move that piece?"
            @display.render
            @display.cursor.get_input 
        end
        end_pos = @display.cursor.cursor_pos
        @display.board.move_piece(@color, start_pos, end_pos)
        @display.render
    end
end