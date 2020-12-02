require "byebug"

class Stack
    DIRECTION = ["left", "right"]

    def initialize(direction=DIRECTION.sample)
      @direction = direction
      @elements = []
    end

    def push(el)
      # adds an element to the stack
      @direction == "left" ? @elements.unshift(el) : @elements << el
    end

    def pop
      # removes one element from the stack
      @direction == "left" ? @elements.shift : @elements.pop
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      @direction == "left" ? @elements.first : @elements.last
    end

end

if $PROGRAM_NAME == __FILE__
    s1 = Stack.new
    p s1
    s1.push("hello")
    s1.push(6)
    s1.push(7)
    s1.push(8)
    p s1
    p s1.pop
    p s1
    p s1.peek
    p s1
end