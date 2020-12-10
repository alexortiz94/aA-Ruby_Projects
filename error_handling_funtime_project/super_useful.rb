require 'numbers_in_words'

# PHASE 0
def convert_to_int(str)
  NumbersInWords.in_numbers(str)
end

# PHASE 1
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise ArgumentError  
  else 
    raise NameError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit) 
rescue NameError => exception
  puts "That is not a fruit!"
rescue ArgumentError => exception
  puts "That is not a fruit, but I could always use a cup-a-joe"
  retry
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    raise ArgumentError.new "name cannot be left blank" if name.length <= 0
    @yrs_known = yrs_known
    raise ArgumentError.new "best friends must have known each other for at least 5 years" if yrs_known < 5
    @fav_pastime = fav_pastime
    raise ArgumentError.new "best friends have to have a favorite pastime" if fav_pastime.length <= 0
  rescue ArgumentError => e
    puts "Couldn't initialize friendship"
    puts "Because #{e.message}"
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known} years. Let's be friends for another #{1000 * @yrs_known} years."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


