require_relative 'card.rb'
require_relative 'board.rb'
require_relative 'HumanPlayer.rb'
require_relative 'ComputerPlayer.rb'
require 'byebug'


class MemoryPuzzleGame
    attr_reader :previous_guess, :board

    def initialize(board)
        @board = board
        board.populate 
        @previous_guess = nil
        @player1 = nil
    end

    # def prompt
    #     puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
    # end

    # def pos
    #     xy = gets.chomp.split(",").map(&:to_i)
    #     begin
    #         raise "That is an invalid position!" if xy.any? {|num| num > 3 || num < 0 }
    #     rescue => exception
    #         puts "Please enter a valid position:"
    #         xy = gets.chomp.split(",").map(&:to_i)    
    #     end
    #     xy 
    # end

    def match?(guessed_pos)
        guessed_pos == @previous_guess
    end


    def reset
        system("clear")
    end

    def make_guess
        xy = @player1.pos(self.board,self.previous_guess)
        @board.reveal(xy)
    end

    def enter_player(player)
        @player1 = player
        puts 'Please enter your name:'
        @player1.name ||= gets.chomp.capitalize
        puts @player1.name
        puts "Welcome #{@player1.name}--Let's start a new game!"
        sleep(2)
    end


    def play(player)
        # debugger
        self.enter_player(player)
        # debugger
        until @board.won?
            system("clear")
            sleep(1)
            guessed_pos = self.take_turn
            if self.match?(guessed_pos)
                puts "It's a match!"
                @player1.previous_matches << guessed_pos 
                sleep(1)
                puts "Nice work #{@player1.name}!"
                sleep(2)
                @previous_guess = nil
            else
                puts "Try again!"
                sleep(2)
                @board.grid.flatten.each {|card| card.hide if card.face_value == guessed_pos || card.face_value == @previous_guess}
                @previous_guess = nil
            end
            
        end
        puts "Congratulations! You've Matched All the Cards!"
        sleep(3)
    end

    def take_turn
        @board.render
        @player1.prompt("first")
        guessed_pos = self.make_guess
        @board.render
        @previous_guess = guessed_pos
        @player1.prompt("second")
        guessed_pos = self.make_guess
        @board.render
        sleep(2)
        guessed_pos
    end




end

if $PROGRAM_NAME == __FILE__
    new_game = MemoryPuzzleGame.new(Board.new)
    new_game.play(ComputerPlayer.new)
end
