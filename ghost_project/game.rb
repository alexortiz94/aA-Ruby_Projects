require 'set'
require 'byebug'
require_relative 'player.rb'

class GhostGame
    attr_reader :players, :fragment, :current_player, :previous_player, :losses
    ALPHABET = ("a".."z").to_a

    def initialize(*players)
        @players = players
        @dictionary = File.readlines('./dictionary.txt').map(&:chomp).to_set
        @fragment = ""
        @current_player = players[0]
        @previous_player = nil
        @losses = {}
        players.each do |player|
            losses[player] = 0
        end
    end

    def next_player!
        if @previous_player.nil?
            @previous_player = @current_player
            @current_player = @players[1]
        else
            @previous_player, @current_player = @current_player, @previous_player
        end
    end

    def valid_play?(letter)
        return false unless letter.length == 1 && ALPHABET.include?(letter)
        @dictionary.any? {|word| word[0..@fragment.length] == @fragment + letter}
    end

    def take_turn
        puts "It's #{@current_player.name}'s turn!"
        letter = ""
        # debugger
        until valid_play?(letter)
            # debugger
            letter = @current_player.guess
            @current_player.alert_invalid_guess if !valid_play?(letter)
            # debugger
        end
        @fragment += letter
        puts "#{@current_player.name} added the letter '#{letter}' to '#{@fragment}'"
    end

    def is_word?(fragment)
        @dictionary.include?(fragment)
    end

    def round_over?
        is_word?(self.fragment)
    end

    def play_round
        @fragment = ""
        puts "Let's play a round of GHOST"
        
        until round_over?
            take_turn
            next_player!
        end


        puts "Round over!"
        sleep(1)
        update_standings
    end

    def record(player)
        player.letters
    end

    def update_standings
        @losses[@previous_player] += 1
        @previous_player.add_letter
        puts "#{@previous_player.name} loses"
        puts "the standings are: "

        @players.each do |player|
            puts "#{player.name} has '#{player.letters}'"
        end
        sleep (2)
    end

    def run
        puts "Welcome!"
        until game_over?
            play_round
        end
        sleep(1)
        puts "Game Over!"
        puts "#{self.winner} wins the game!"
    end

    def game_over?
        count = @losses.values.count {|v| v == 5}
        if count == players.count - 1
            true
        end
    end

    def winner
        @losses.each do |player,v|
            if v < 5
                return player.name
            end
        end
    end

    
end

if $PROGRAM_NAME == __FILE__
    new_game = GhostGame.new(Player.new("alex"), Player.new("jonathan"))
    new_game.run
end
