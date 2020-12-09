class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player_one = name1
    @player_two = name2
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
    current_player = current_player_name == @player_one ? @player_one : @player_two
    starting_cup = @cups[start_pos]
    in_hand = Array.new(starting_cup.count) { starting_cup.pop }
    next_cup_index = start_pos + 1 
    until in_hand.empty?
      if current_player == @player_one
        @cups[next_cup_index] << in_hand.pop unless next_cup_index == 13
      else  
        @cups[next_cup_index] << in_hand.pop unless next_cup_index == 6
      end
      ending_cup_idx = next_cup_index 
      next_cup_index == 13 ? next_cup_index = 0 : next_cup_index += 1
    end
    self.render

    next_turn(ending_cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13 
    return :switch if @cups[ending_cup_idx].count <= 1
    return ending_cup_idx if @cups[ending_cup_idx].count > 1   
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if @cups[0..5].all? { |cup| cup.empty? } || @cups[7..12].all? { |cup| cup.empty? }
    false
  end

  def winner
    player_one_score = @cups[6].count
    player_two_score = @cups[13].count
    case player_one_score <=> player_two_score
    when 1
      return @player_one
    when -1
      return @player_two
    when 0
      return :draw
    end
  end
end
