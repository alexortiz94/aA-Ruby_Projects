require 'byebug'
require_relative 'board.rb'
require_relative 'tile.rb'

class SudokuGame
    attr_reader :board

    def initialize(file)
        @board = Board.new(file)
    end

    def get_position
        puts "Enter the position of the tile you want to change (e.g., 2,3)"
        print ">"
        xy = gets.chomp.split(',').map(&:to_i)
        tile = @board.position(xy)
        begin
            raise "You cannot change the value of a given tile" if tile.given
        rescue => exception
            puts "please enter a valid position"
            print ">"
            xy = gets.chomp.split(',').map(&:to_i) 
        end
        xy
    end

    def get_number
        puts "Enter a number that you want to write in the tile"
        print ">"
        num = gets.chomp.to_i
        begin
            raise "The only valid numbers are 1-9" if num < 1 || num > 9
        rescue
            puts "Enter a number that you want to write in the tile"
            print ">"
            num = gets.chomp.to_i
        end
        num
    end

    def play
        puts "Let's play a game of sudoku!"
        sleep(2)
        until @board.solved?
            system("clear")
            @board.render
            # sleep(2)
            xy = self.get_position
            num = self.get_number
            @board.change_value(xy, num)
            @board.render
            # sleep(2)
        end
        puts "Congratulations you solved the puzzle!"
    end
end

if $PROGRAM_NAME == __FILE__
    s1 = SudokuGame.new('sudoku1_almost.txt')
    s1.play

end