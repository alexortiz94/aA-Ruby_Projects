require 'byebug'
require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'game.rb'

class ComputerPlayer
    attr_reader :name, :known_cards, :previous_matches
    attr_writer :name
    POSSIBLE_MOVES = [0,1,2,3]

    def initialize
        @name = "Compubot"
        @known_cards = Hash.new { |h, k| h[k] = [] }
        @previous_matches = []
    end

    def prompt(number)
        puts "Please enter the position of the #{number} card you'd like to flip (e.g., '2,3')"
    end

   def receive_revealed_card(xy, board)
        @known_cards[xy] = board.reveal(xy).to_s
   end

   def check_for_pairs(board, value=nil)
        counter = Hash.new(0) 
        @known_cards.values.each { |v| counter[v] += 1 }
        if (value != nil) && (counter[value] > 1)
            @known_cards.each { |xy, v| return xy if v == value}
        elsif counter.any? {|face_value, count| count > 1 }
            pairs = counter.keys.select {|face_value| counter[face_value] > 1 }
            @known_cards.each { |xy, v| return xy if pairs.include?(v) && !previous_matches.include?(v) && board.guessed_pos(xy).face_up == false}
        end  
        false
   end


   
   def pos(board,previous_guess)
        # debugger
        if previous_guess.nil? #&& board.guessed_pos(xy).face_up == false
            # debugger
            xy = self.check_for_pairs(board)
            xy ||= [POSSIBLE_MOVES.sample,POSSIBLE_MOVES.sample] 
            until board.guessed_pos(xy).face_up == false && (!@known_cards.has_key?(xy) unless self.check_for_pairs(board))
                # debugger
                xy = [POSSIBLE_MOVES.sample,POSSIBLE_MOVES.sample]
            end
            # debugger
            self.receive_revealed_card(xy, board)
        else
            # debugger
            xy = self.check_for_pairs(board, previous_guess)
            xy ||= [POSSIBLE_MOVES.sample,POSSIBLE_MOVES.sample] 
            until board.guessed_pos(xy).face_up == false
                # debugger
                xy = [POSSIBLE_MOVES.sample,POSSIBLE_MOVES.sample]
            end 
            # debugger
            self.receive_revealed_card(xy, board)
        end
        puts xy.join(',')
        sleep(2)
        xy
   end

end

if $PROGRAM_NAME == __FILE__
    player1 = ComputerPlayer.new
    p player1
    p player1.name
    board = Board.new
    board.populate
    board.render
    p player1.pos(board)
    p player1
    
end





