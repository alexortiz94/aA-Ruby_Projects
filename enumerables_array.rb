require "byebug"

class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            ele = self[i]
            prc.call(ele)
            i += 1
        end
        self
    end

    def my_select(&prc)
        selected = []
        self.my_each { |ele| selected << ele if prc.call(ele)}
        selected
    end

    def my_reject(&prc)
        unrejected = []
        i = 0
        while i < self.length
            ele = self[i]
            if !prc.call(ele)
                unrejected << ele
            end
            i += 1 
        end
        unrejected
    end

    def my_any?(&prc)
        self.my_each {|ele| return true if prc.call(ele)}
        false
    end

    def my_all?(&prc)
        self.my_each {|ele| return false if !prc.call(ele)}
        true
    end

    def my_flatten
        flattened = []
        self.each do |el|
            if el.is_a?(Array)
                flattened.concat(el.my_flatten)
            else
                flattened << el
            end
        end
        flattened
        # if self.first.is_a?(Array)
        #     [*self.first].concat(self[1...self.length]
        # else  
        #     [self.first] + self[1...self.length].my_flatten
        # end
    end

    def my_zip(*arrays)
        zipped = Array.new(self.length) {Array.new}
        i = 0
        while i < self.length
            zipped[i] << self[i]
            arrays.each do |array|
                if array[i].nil?
                    zipped[i] += [nil]
                else
                    zipped[i] << array[i]
                end
            end
            i += 1
        end
        zipped
    end

    def my_rotate(n=1)
        new_arr = []
        if n > 0
            n.times {|i| new_arr = self.push(self.shift)}   
        else
            n.abs.times {|i| new_arr = self.unshift(self.pop)} 
        end
        new_arr  
    end

    def my_join(str_sep='')
        new_str = ''
        self.each_with_index do |char, idx|
            if idx < self.length - 1
                new_str += char + str_sep
            else
                new_str += char
            end
        end
        new_str
    end

    def my_reverse
        reverse = []
        i = self.length - 1
        while i >= 0
            reverse << self[i]
            i -= 1
        end
        reverse
        # reversed = []
        # self.my_each do |el|
            # reversed.unshift(el)
        # end
        # reversed
    end


end

