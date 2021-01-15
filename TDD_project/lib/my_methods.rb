require "byebug"

class Array

    def my_uniq 
        unique_array = []
        self.each { |el| unique_array << el unless unique_array.include?(el) }
        unique_array
    end

end

