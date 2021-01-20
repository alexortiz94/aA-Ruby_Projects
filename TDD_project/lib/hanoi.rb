require "byebug"

class TowersOfHanoi
    attr_reader :stacks 

    def initialize
        @stacks = [[3, 2, 1], [], []]
    end

    def play
        puts "Welcome to the Towers of Hanoi game!"
        until won?
            display
            puts "Pick a stack you want to move the top disk from, and the stack you want to move it to: e.g., 0,1"
            p ">"
            stack_indexes = gets.chomp.split(",").map(&:to_i)
            from_stack = @stacks[stack_indexes.first]
            to_stack = @stacks[stack_indexes.last]
            move(from_stack, to_stack)
        end
        puts "You beat the puzzle!"
    end

    def move(from_stack, to_stack)
        raise "that stack is empty" if from_stack.empty?
        raise "you cannot move a larger disk on top of a smaller one" if !to_stack.empty? && from_stack.last > to_stack.last 
        disk = from_stack.pop
        to_stack << disk
    end

    def won?
        @stacks[0].empty? && @stacks[1..2].any?(&:empty?)
    end

    def display
        render_string = [2, 1, 0].map do |height|
            @stacks.map do |stack|
                stack[height] || " "
            end.join("\t")
        end.join("\n")
        render_string << "\n-----------------\n"
        render_string << "0       1       2\n"
        puts render_string
    end

end

if $PROGRAM_NAME == __FILE__
    g1 = TowersOfHanoi.new
    g1.play
end



