require 'byebug'

def range(start, finish)
    return [] if finish <= start  
    [start] + range(start + 1, finish)
end

p range(1, 5)

def range(start, finish)
    arr = []
    return arr if finish <= start 
    (start...finish).each { |i| arr << i }
    arr
end

p range(1, 5)


def exponent(base, power)
    return 0 if base == 0
    return 1 if power == 0 
    base * exponent(base, power - 1)
end

def exponent(base, power)
    return 0 if base == 0
    return 1 if power == 0
    return base if power == 1
    if power.even?
        exponent(base, power / 2) ** 2
    else
        base * (exponent(base, (power - 1)/2) ** 2)
    end
end


p exponent(0,0)
p exponent(0,1)
p exponent(1,0)
p exponent(1,1)
p exponent(2,0)
p exponent(2,1)
p exponent(2,2)
p exponent(2,4)
p exponent(3,5)


class Array

    def deep_dup
        # debugger
        return self.dup if self.is_a?(Array) && self.length <= 1
        # debugger
        deeps = []
        self.each.with_index do |subArr, idx|
            # debugger
            if subArr.is_a? Array
                # debugger
                deeps << subArr.dup
                deeps[idx] = subArr.deep_dup
            else
                # debugger
                deeps << subArr
            end
            # debugger
        end
        deeps
    end
end

arr = [1, [2], [3, [4]]]
d1 = arr.deep_dup
p d1
d1[2][1] << 5
p d1
p arr


def fibonacci_iter(n)
    return [] if n == 0
    return [0] if n == 1

    fibs = [0,1]

    while fibs.count < n
        fibs << fibs[-2] + fibs[-1]
    end
    
    fibs
end

def fibonacci_rec(n)
    if n <= 2
        [0,1].take(n)
    else
        fibs = fibonacci_rec(n -1)
        fibs << fibs[-2] + fibs[-1]
    end
end

puts "Test Cases: fibonacci"
print "\n"

p fibonacci_iter(7)
p fibonacci_rec(7)
p fibonacci_iter(14)
p fibonacci_rec(14)


def bsearch(array, target)
    return nil if array.empty?
    mid_idx = array.size/2
    return mid_idx if target == array[mid_idx]
    if target > array[mid_idx]
        start_idx = mid_idx + 1 
        target_index = bsearch(array[start_idx..-1], target)
        unless target_index.nil?
            target_index += start_idx
        end    
    else
        target_index = bsearch(array[0...mid_idx], target)
    end
end
    
puts "Test Cases: bsearch"
print "\n"

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array

    def merge_sort
        # debugger
        return self if self.size < 2
        mid_idx = self.size/2
        # debugger
        sorted_left, sorted_right = self[0...mid_idx].merge_sort, self[mid_idx..-1].merge_sort
        # debugger
        merge(sorted_left,sorted_right)
    end

    def merge(left, right)
        merged = []
        # debugger
        until left.empty? || right.empty?
            # debugger
            merged << (left.first < right.first ? left.shift : right.shift)
        end
        # debugger
        merged + left + right
    end
end

puts "Test Cases: merge_sort"
print "\n"
arr = Array.new(8) { (0..100).to_a.sample }
p arr
p arr.merge_sort
p arr
        

class Array
    
    def subsets
        return [[]] if self.empty?
        size = self.count
        last = self[-1]

        left = self.take(size-1).subsets    
        right = left.map {|sub| [*sub, last]}
      
        subsets = left + right
        
    end
end

puts "Test Cases: subsets"
print "\n"
p [].subsets # => [[]]
p [1].subsets # => [[], [1]]
p [1, 2].subsets # => [[], [1], [2], [1, 2]]
p [1, 2, 3].subsets # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# p [1, 2, 3, 4].subsets

def permutations(array)
    return [array] if array.length <= 1
    total_permutations = []
    first = array.shift
    perms = permutations(array)

    perms.each do |perm|
        (0..perm.length).each do |i|
            total_permutations << perm[0...i] + [first] + perm[i..-1]
        end
    end
    total_permutations
end

puts "Test Cases: permutations"
print "\n"
p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
# p permutations([5, 11, 4, 6])

def greedy_make_change(amount, coins)
    return [] if coins.empty? || amount == 0
    # debugger
    coins = coins.sort.reverse
    biggest_coin = coins.first
    x = amount/biggest_coin
    amount %= biggest_coin

    # debugger
    change = Array.new(x) {biggest_coin}
    # debugger
    coins.shift 
    change += greedy_make_change(amount, coins)
    # debugger
end

def make_better_change(amount, coins)
    # debugger
    return [] if amount == 0
    return nil if coins.none? {|coin| coin <= amount}
    coins.sort! {|a, b| b <=> a}
    best_change = nil
    # debugger
    coins.each.with_index do |coin, idx|
        next if coin > amount
        # debugger
        remainder = amount - coin
        best_remainder = make_better_change(remainder, coins.drop(idx))
        # debugger
        next if best_remainder.nil?
            
        
        # debugger
        change = [coin] + best_remainder
        if best_change.nil? || (change.count < best_change.count)
            # debugger
            best_change = change
        end
        
    end
    best_change
end
    
puts "Test Cases: make_change"
print "\n"
p greedy_make_change(39, [25, 10, 5, 1])
p greedy_make_change(58, [25, 10, 5, 1])
p greedy_make_change(69, [25, 10, 5, 1])
p greedy_make_change(24, [10, 7, 1])
p make_better_change(24, [10, 7, 1])


     
            
        






