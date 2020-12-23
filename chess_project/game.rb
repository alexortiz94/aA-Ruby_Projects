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
        # debugger
        puts "Welcome! Let's start a game of chess!"
        sleep(2)
        until players.values.any? {|v| @board.checkmate?(v.color)}
            puts "it is #{@current_player}'s turn, your color is #{@players[self.current_player].color}"
            notify_players
            sleep(2)
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
        winning_color = (@board.checkmate?(:white) ? :black : :white )
        winner = players.each { |k, v| return k if v.color == winning_color }
        puts "Game over the winner is #{winner}!"
        sleep(4)
    end

    private

    def swap_turn!
        @current_player = (self.current_player == :player_one ? :player_two : :player_one)
    end

    def notify_players
        puts "You are in check!" if board.in_check?(players[current_player].color)
    end
            
end

chess = Game.new
chess.play


