require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece

    include Slideable

    def symbol
        raise NotImplementedError
    end

    private

    def move_dirs
        diaganol_dirs
    end
end