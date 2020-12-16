
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []

  end

  def play
    until self.game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message
    self.sequence_length += 1 unless @game_over
  end

  def show_sequence
    add_random_color
    self.seq.each do |color|
      system("clear")
      sleep(1)
      p color
      sleep(1)
    end
  end

  def require_sequence
    puts "Enter the color sequence in order starting with the first"
    sleep(1)
    self.seq.each do |seq_color|
      system("clear")
      puts "Enter color"
      print ">"
      user_input = gets.chomp
      if user_input != seq_color
        @game_over = true
        break
      end
      sleep(1)
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "You got the sequence right!" unless self.game_over
  end

  def game_over_message
    puts "Game Over! Your highest score was #{@sequence_length}!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if $PROGRAM_NAME == __FILE__
  new_game = Simon.new
  new_game.play
end