require 'byebug'
require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'card.rb'


class Array

    def twice?(&prc)
        count = 0
        self.each do |ele|
            count += 1 if prc.call(ele)
        end
        count == 2
    end

end




class HumanPlayer
    attr_reader :name, :moves, :previous_matches
    attr_writer :name

    def initialize
        @name = nil
        @known_cards = 0
        @previous_matches = []
    end

    def prompt(number)
        puts "Please enter the position of the #{number} card you'd like to flip (e.g., '2,3')"
    end

    def pos(board)
        xy = gets.chomp.split(",").map(&:to_i)
        begin
            raise "That is an invalid position!" if xy.any? {|num| num > 3 || num < 0 }
        rescue => exception
            puts "Please enter a valid position:"
            xy = gets.chomp.split(",").map(&:to_i)    
        end
        # debugger
        if board.grid.flatten.twice? {|card| card == board.guessed_pos(xy) && card.face_up == true }
        # debugger
            begin
                raise "That card has already been matched!"
            rescue => exception
               puts "Please enter a position of a card that is face down"
               xy = gets.chomp.split(",").map(&:to_i)
            end
        end
        xy
    end
end