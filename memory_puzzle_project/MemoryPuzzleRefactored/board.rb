require 'set'
require 'byebug'
require_relative 'card.rb'

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(4) {Array.new(4,nil)}
    end

    def populate
        until full?
            # debugger
            pairs = generate_unique_pairs 
            pairs.each do |pair|
                # debugger
                until @grid.flatten.map{|card| card.object_id}.include?(pair.object_id)
                    # debugger
                    x = rand(4)
                    y = rand(4)
                    @grid[x][y] ||= pair
                    # debugger
                end
            end
        end
    end

    def full?
        @grid.none? do |row|
            row.any? {|val| val.nil?}
        end
    end

    def generate_unique_pairs
        pair1 = Card.new 
        until !unique_pairs.include?(pair1.face_value)
            pair1 = Card.new
        end
        pair2 = pair1.dup
        *pairs = pair1, pair2
    end

    def unique_pairs
        arr = @grid.flatten.map do |ele|
            if ele.is_a? Card
                ele.face_value
            else
                ele
            end
        end.to_set      
        # This method at the end is called on 'arr' and is useful by removing all duplicates
    end

    def render
        i = 0
        board = @grid.map do |row|
            row.map.with_index do |card, idx|
                if card.face_up
                    card.to_s
                else
                    'X'
                end 
            end.join(' ')
        end.join("\n")
        while i <= 3
            board.insert((i*10), "#{i} ")
            i += 1
        end
        print "  0 1 2 3\n"
        print board + "\n"
    end

    def guessed_pos(xy)
        x, y = *xy
        @grid[x][y]
    end

    def reveal(xy)
        card = self.guessed_pos(xy)
        if card.face_up == false
            card.reveal
        end
        card.face_value
    end

    def won?
        self.grid.flatten.all? { |card| card.face_up == true }
    end



end

if $PROGRAM_NAME == __FILE__
    board = Board.new
    p board
    board.populate
    p board.unique_pairs
    board.render
    # array = [1,2,2,1,4,4,5,6,7,8,5,6]
    # set = array.to_set
    # p set 
end
