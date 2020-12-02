require 'byebug'
require_relative 'tile.rb'


class Board
    attr_reader :grid

    def self.from_file(file)
        board = File.readlines(file).map(&:chomp)
        board.map do |row|
            row.split("").map do |tile|
                value = tile.to_i
                if value == 0
                    Tile.new(value)
                else   
                    Tile.new(value, true)
                end
            end

        end
    end


    def initialize(file)
        @grid = Board.from_file(file)
    end

    def render
        i = -1
        board = @grid.map.with_index do |row, idx1|
                
            row.map.with_index do |tile, idx2|
                if idx1 % 3 == 0 && idx2 == 0 && idx1 != 0
                    i += 1 
                    "  " + "---------------------\n".on_white + "#{i} " + tile.to_s
                elsif idx2 % 3 == 0 && idx2 != 0
                    "| ".on_white + tile.to_s
                elsif idx2 == 0
                    i += 1 
                    "#{i} " + tile.to_s
                    
                else
                    tile.to_s
                end
            end.join(' '.on_white)
        end.join("\n")
        # while i <= 8
        #     board.insert((i*20), "#{i} ")
        #     i += 1
        # end
        print "  0 1 2   3 4 5   6 7 8\n"
        print board + "\n"    
    end

    def position(xy)
        x, y = xy
        @grid[x][y]
    end

    def change_value(xy, num)
        tile = self.position(xy)
        tile.value = num
    end

    def check_rows
        @grid.each do |row|
            count = Hash.new
            (1..9).each {|value| count[value] = 0 }
            row.each do |tile|
                return false if tile.value == 0
                count[tile.value] +=1
            end
            return false if count.values.any? {|value| value != 1 }
        end
        true
    end

    def check_columns
        transposed = @grid.transpose
        transposed.each do |col|
            count = Hash.new
            (1..9).each {|value| count[value] = 0 }

            col.each do |tile|
                return false if tile.value == 0 
                count[tile.value] +=1
            end                
            return false if count.values.any? {|value| value != 1 }
        end
        true
    end

    def check_blocks
        blocks = []
        i = 0
        r = 0
        until blocks.length == 9
            block = []
            (r..r+2).each do |row|
                (i..i+2).each do |col|
                    
                    tile = @grid[row][col]
                    block << tile
                end
            end
            blocks << block
            i += 3
            if i >= 8
                i = 0
                r += 3
            end
        end
        blocks.each do |block|
            count = {}
            (1..9).each {|num| count[num] = 0}
            block.each do |tile|
                return false if tile.value == 0 
                count[tile.value] += 1
            end
            return false if count.values.any? {|value| value != 1 }
        end
        true
    end

    def solved?
        self.check_rows && self.check_columns && self.check_blocks
    end

            




            

            

end

if $PROGRAM_NAME == __FILE__
    b1 = Board.new('sudoku1.txt')
    b1.render
    p b1.solved?
    p b1.position([0,0]).value

end