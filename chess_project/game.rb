require_relative 'board'
require_relative 'display'
require_relative 'human_player'


class Game

    attr_reader :board, :display, :players, :current_player

    def initialize
        @board = Board.new
        @display = Display.new(self.board)
        @players = { player_one: HumanPlayer.new(:white, self.display), player_two: HumanPlayer.new(:black, self.display) }
        @current_player = :player_one
    end

    def play
        puts "Welcome! Let's start a game of chess!"
        sleep(2)
        until players.values.any? {|v| @board.checkmate?(v.color)}
            puts "it is #{@current_player}'s turn, your color is #{@players[self.current_player].color}"
            sleep(3)
            begin
                @players[self.current_player].make_move
            rescue => exception
                puts "There was an error during your turn"
                puts "#{exception.message}"
                sleep(2)
                retry
            end
            swap_turn!
        end
        winner = (@board.checkmate?(:white) ? :white : :black)
        puts "Game over the winner is #{@players.each { |k, v| return k if v.color == winner } }!"
    end

    def swap_turn!
        @current_player = (self.current_player == :player_one ? :player_two : :player_one)
    end
end

chess = Game.new
chess.play


