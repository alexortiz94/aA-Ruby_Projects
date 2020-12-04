require_relative "PolyTreeNode.rb"

class KnightPathFinder

    attr_reader :start_pos, :considered_positions, :root_node


    MOVES = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]

    def self.valid_moves(pos)
        start_x, start_y = *pos
        valid_moves = []

        MOVES.each do |dxdy|
            d_x, d_y = *dxdy
            new_position = [start_x + d_x, start_y + d_y]
            valid_moves << new_position if new_position.all? { |coord| (0..7).to_a.include?(coord) }
        end

        valid_moves
    end



    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        @root_node = PolyTreeNode.new(start_pos.dup)
        build_move_tree
    end

    def new_move_positions(pos)
        new_positions = self.class.valid_moves(pos).reject { |coord| @considered_positions.include?(coord) }
        @considered_positions += new_positions
        new_positions
    end

    def build_move_tree
        queue = [self.root_node]
        until queue.empty?
            xy = queue.shift
            new_move_positions(xy.value).each do |pos| 
                new_move = PolyTreeNode.new(pos)
                xy.add_child(new_move)
                queue << new_move
            end
        end
    end

end


