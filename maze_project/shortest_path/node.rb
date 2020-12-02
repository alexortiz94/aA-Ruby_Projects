require 'byebug'

class Node

    def initialize(parent, movement_cost, position)
        @parent = parent
        @g_score = movement_cost + parent.g_score unless
        @h_score = nil
        @f_score = @g_score + @h_score 