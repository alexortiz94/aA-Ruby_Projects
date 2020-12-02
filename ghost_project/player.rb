require 'byebug'

class Player
    attr_reader :name, :letters

    LETTERS = "GHOST"

    def initialize(name)
        @name = name.capitalize
        @letters = ""
    end

    def guess
        puts "Pick a letter"
        gets.chomp.downcase
    end

    def alert_invalid_guess
        puts "#{self.name} that guess is invalid"
    end

    def add_letter
        count = @letters.length + 1
        @letters = LETTERS.slice(0, count)
    end


end

    