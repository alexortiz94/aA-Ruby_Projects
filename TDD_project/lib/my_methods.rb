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

    def my_transpose
        transposed = []
        (0..2).each do |col_idx|
            col = []
            self.each do |row| 
    
                col << row[col_idx]
            end

            transposed[col_idx] = col
        end
        transposed
    end

    def stock_picker
        raise "all elements must be numbers" unless self.all? { |el| el.is_a?(Integer) }
        high = self.max
        low = nil
        self.each_with_index do |el, idx|
            next_el = self[idx + 1]
            break if next_el ==  high
            
            low ||= (el < next_el) ? el : next_el
            low = el if el < low
        end
        buy_and_sell_days = [ self.index(low) , self.index(high) ]
    end




end

