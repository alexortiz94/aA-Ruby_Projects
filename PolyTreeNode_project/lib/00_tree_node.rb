class PolyTreeNode

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    attr_reader :value, :parent, :children

    def parent=(node)
        # assigning nil to parent
        if node.nil?
            @parent = nil
            return nil
        end
        # assigning a new parent/different parent
        if self.parent == nil 
            @parent = node
        else
            @parent.children.delete(self)
            @parent = node
        end
        # add our node to the parents children atttribute  
        node.children << self unless node.children.include?(self)
        self.parent
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "argument is not a child" if child_node.parent == nil
        child_node.parent.children.delete(child_node)
        child_node.parent = nil
    end
    
    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value == target_value
            el.children.each { |child| queue << child }
        end
        nil
    end



end

