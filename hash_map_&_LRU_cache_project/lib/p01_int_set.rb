require 'byebug'

class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true 
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false if @store[num] == true
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    num %= @store.length
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << (num) 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def inspect
    @store
  end

  def insert(num)
    resize! if self.count == num_buckets
    unless self[num].include?(num)
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    previous_elements = @store.dup.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    previous_elements.each { |el| self.insert(el) }
  end
end
