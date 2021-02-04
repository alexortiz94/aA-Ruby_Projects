class LRUCache
  attr_reader :physical_capacity, :full
  alias_method :full?, :full  

  def initialize(capacity)
    @physical_capacity = capacity
    @cache = Array.new(capacity)
    @full = (self.count == capacity)
  end

  def count
    count = 0
    @cache.each { |el| count += 1 unless el.nil? }
    count
  end

  def add(el) 
    @cache.include?(el) ? @cache.delete(el) : (@cache.shift unless self.full?)
    @cache << el

  end

  def show
    p @cache
    nil
  end

  private
  # helper methods go here!
  

end