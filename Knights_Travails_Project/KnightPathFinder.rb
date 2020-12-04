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

    def find_path(end_pos)
        end_node = self.root_node.dfs(end_pos)
        path = trace_back_path(end_node).reverse
        p path
    end

    def trace_back_path(end_node)
        path_backtrace = [end_node]
        until path_backtrace.last.parent == nil
            current_node = path_backtrace.last.parent
            path_backtrace << current_node
        end
        path_backtrace.map(&:value)
    end


end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0,0])
    kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
    kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end



