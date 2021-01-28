class String

    # Phase 1
    def first_anagram?(str)
        anagrams = self.split("").permutation.map(&:join)
        anagrams.include?(str)
    end
    # time complexity is O(n!) and space complexity is O(n!)

    # Phase 2
    def second_anagram?(str)
        return false if self.length != str.length
        str_array = str.split("")
        self.each_char.with_index do |char, idx|
            break if str_array.find_index(char) == nil
            str_array.delete_at(str_array.find_index(char)) 
        end
        str_array.empty?
    end
    # time complexity is O(n^2) 

    # Phase 3
    def third_anagram?(str)
        return false if self.length != str.length
        str_array = str.split("").sort
        str_array == self.split("").sort
    end
    # time complexity is O(n log(n))

    # Phase 4
    def fourth_anagram?(str)
        return false if self.length != str.length
        counter = Hash.new(0)
        str.length.times do |i|
            counter[str[i]] += 1
            counter[self[i]] -= 1
        end
        counter.values.all? { |count| count == 0 }
    end
    # time complexity is O(n) and constant space O(1)



end    
