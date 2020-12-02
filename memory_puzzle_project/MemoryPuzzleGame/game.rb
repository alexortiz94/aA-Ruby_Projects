require_relative 'card.rb'
require_relative 'board.rb'
require 'byebug'


class MemoryPuzzleGame
    attr_reader :previous_guess, :board

    def initialize(board)
        board.populate
        @board = board 
        @previous_guess = nil
    end

    def prompt
        puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
    end

    def pos
        xy = gets.chomp.split(",").map(&:to_i)
        begin
            raise "That is an invalid position!" if xy.any? {|num| num > 3 || num < 0 }
        rescue => exception
            puts "Please enter a valid position:"
            xy = gets.chomp.split(",").map(&:to_i)    
        end
        xy 
    end

    def match?(guessed_pos)
        guessed_pos == @previous_guess
    end


    def reset
        system("clear")
    end

    def make_guess
        xy = self.pos
        @board.reveal(xy)
    end

    def play
        until @board.won?
            system("clear")
            sleep(1)
            @board.render
            self.prompt
            guessed_pos = self.make_guess
            @board.render
            @previous_guess = guessed_pos
            self.prompt
            guessed_pos = self.make_guess
            @board.render
            sleep(2)
            if self.match?(guessed_pos)
                puts "It's a match!"
                sleep(2)
            else
                puts "Try again!"
                sleep(2)
                @board.grid.flatten.each {|card| card.hide if card.face_value == guessed_pos || card.face_value == @previous_guess}
            end
        end
        puts "Congratulations guy! You've Matched All the Cards!"
    end





end

if $PROGRAM_NAME == __FILE__
    new_game = MemoryPuzzleGame.new(Board.new)
    new_game.play
end
