require "byebug"

# my_min
# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# my_min(list)  =>  -5

# Phase 1
def my_min_1(array)
    array.each_with_index do |num, idx|
        other_numbers = array.take(idx) + array.drop(idx+1)
        return num if other_numbers.all? { |other_num| other_num > num }
    end
end
# time complexity is O(n^2)

# Phase 2
def my_min_2(array)
    my_min = array.first
    array.drop(1).each do |num|
        my_min = num if num < my_min
    end
    my_min
end
# time complexity is O(n) and space complexity is O(1)


# Largest contiguous sub-sum
# example 1
    # list = [5, 3, -7]
    # largest_contiguous_subsum(list) # => 8

    # possible sub-sums
    # [5]           # => 5
    # [5, 3]        # => 8 --> we want this one
    # [5, 3, -7]    # => 1
    # [3]           # => 3
    # [3, -7]       # => -4
    # [-7]          # => -7
# example 2
    # list = [2, 3, -6, 7, -6, 7]
    # largest_contiguous_subsum(list) => 8 (from [7, -6, 7])
# example 3
    # list = [-5, -1, -3]
    # largest_contiguous_subsum(list) => -1 (from [-1])


# Phase 1
def largest_contiguous_subsum_1(array)
    subsets = []
    array.each_index do |i|
        array.each_with_index do |el, idx|
            next if idx < i
            subsets << array[i..idx]
        end
    end
    subset_sums = subsets.map(&:sum)
    subset_sums.each_with_index do |sum, idx|
        other_sums = subset_sums.take(idx) + subset_sums.drop(idx+1)
        return sum if other_sums.all? { |other_sum| sum > other_sum}
    end
end
# time complexity is best case 0(n^2) probably even 0(n^3) on average

# Phase 2
def largest_contiguous_subsum_2(array)
    return nil if array.empty?
    return array.first if array.length == 1

    largest_sum = array[0]

    array.each_index do |i|
        next if i == 0 || i == array.length - 1

        *current_sum = array[0..i].sum, array[i], array[i...array.length].sum  
    
        largest_sum = current_sum.max if current_sum.max > largest_sum
    end
    largest_sum
end
# time complexity is O(n) and space complexity is constant

p largest_contiguous_subsum_2(list)



    










        
