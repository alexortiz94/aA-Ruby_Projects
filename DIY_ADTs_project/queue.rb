class Queue

    def initialize
        @order = []
    end

    def enqueue(el)
        @order << el
    end

    def dequeue
        @order.shift
    end

    def peek
        @order.first
    end
end

if $PROGRAM_NAME == __FILE__
    concert_lineup = Queue.new
    p concert_lineup
    concert_lineup.enqueue("Mark")
    concert_lineup.enqueue("Darren")
    concert_lineup.enqueue("Alex")
    concert_lineup.enqueue("Carolyne")
    p concert_lineup
    p concert_lineup.dequeue
    p concert_lineup
    p concert_lineup.peek
    p concert_lineup
    p concert_lineup.dequeue
    p concert_lineup
end