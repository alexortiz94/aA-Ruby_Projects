require "byebug"

class Array

    def my_uniq 
        unique_array = []
        self.each { |el| unique_array << el unless unique_array.include?(el) }
        unique_array
    end

    def two_sum
        zero_sums = []
        idx1 = 0
        while idx1 < self.length
            self.each_with_index do |el, idx2|
                if idx2 > idx1
                    pair = [self[idx1], el]
                    zero_sums << [idx1, idx2] if pair.sum == 0
                end
            end
            idx1 += 1
        end
        zero_sums
    end


end

