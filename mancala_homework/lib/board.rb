class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player_one_name = name1
    @player_two_name = name2
    @cups = Array.new(14) { Array.new }
    
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, cup_idx|
      4.times { |i| cup << :stone } unless cup_idx == 6 || cup_idx == 13
    end 
  end

  def valid_move?(start_pos)
    valid_cups = (0..5).to_a + (7..12).to_a
    raise "Invalid starting cup" unless valid_cups.include?(start_pos)
    raise "Starting cup is empty" if @cups[start_pos].empty?
    true 
  end

  def make_move(start_pos, current_player_name)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
