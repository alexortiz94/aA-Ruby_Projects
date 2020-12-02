require 'byebug'

class MazeSolver
    attr_reader :maze, :current_position

    def initialize(file)
        @maze = File.readlines(file).map(&:chomp)
        @height = @maze.length
        @width = @maze.first.length
        @current_position = self.find_start
        @open_list = [Node.new(nil,)]
    end

    def position(row, col)
        @maze[row][col]
    end

    def find_start
        pos = []
        @maze.each_with_index do |line, row|
            line.each_char.with_index do |char, col|
                if char == "S"
                    pos = row, col
                    break
                end
            end
        end
        pos
    end

    def find_end
        pos = []
        searching = true
        @maze.each_with_index do |line, row|
            break if !searching
            line.each_char.with_index do |char, col|
                if char == "E"
                    pos = row, col
                    break
                end
            end
        end
        pos
    end

    def print
        @maze.each do |row|
            puts row
        end
    end

    def valid_move?(row, col)
        move = self.position(row, col)
        if move == "*" || move == "X" || move == "S"
            return false
        elsif (col == 0) || (col == @width - 1)
            return false
        elsif (row == 0) || row == @height - 1
            return false
        end
        true
    end

    def solved?
        return true if self.position(*@current_position) == "E"
        false
    end

    def mark_path!(row, col)
        @maze[row][col] = "X"
    end

    def move_up(new_pos)
        move_right(new_pos)
        new_pos[0] -= 1
        new_pos
        # move = row - 1
        # mark_path(*@current_position)
    end

    def move_down(new_pos)
        new_pos[0] += 2
        new_pos

    end

    def move_right(new_pos)
        new_pos[1] += 1
        new_pos
    end

    def move_left(new_pos)
        new_pos[1] -= 2
        new_pos
    end

    def make_move!
        start_pos = @current_position
        new_pos = @current_position.dup
        # debugger
        until  new_pos != start_pos
            # debugger
            # exitt
            # debugger
            if self.valid_move?(*self.move_right(new_pos))
                @current_position = new_pos                         #runnning into problems here because the variable is changing everytime the method is called
            elsif self.valid_move?(*self.move_left(new_pos))
                @current_position = new_pos
            elsif self.valid_move?(*self.move_up(new_pos))
                @current_position = new_pos
            elsif self.valid_move?(*self.move_down(new_pos))
                # debugger
                @current_position = new_pos
            end
            # debugger
        end
        self.mark_path!(*@current_position) unless position(*@current_position) == "E"
        # debugger
    end 



    def solve
        # debugger
        until self.solved?
            # debugger 
            self.make_move!
        end
        # debugger

    end
            
        


end

p m1 = MazeSolver.new('maze1.txt')
m1.print
p m1.find_end
p m1.solved?
m1.make_move!
m1.print
m1.solve
m1.print
