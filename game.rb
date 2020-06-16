require 'pry'

#plays game
class Game

  def initialize
    @word_master = WordMaster.new
    @word_guesser = WordGuesser.new
    @good_guesses = Array.new(@code_word.length, '_')
    @bad_guesses = []
    @tries = 0
  end

  #plays game
  def play_game

  end

  #saves game to finish later
  def save_game

  end

  #loads unfinished game
  def load_game

  end

  #saves guess to appropriate array
  def save_guess
    if good_guess?
      matching_indexes(@word_master.code_word, @word_guesser.guess).each do |i|
        @good_guesses[i] = @word_guesser.guess
      end
    else
      @bad_guesses.push(@word_guesser.guess)
    end
  end  
  
  #checks if guess is good
  def good_guess?
    @word_master.code_word.include?(@word_guesser.guess)
  end

  #returns array of all matching indexes for 
  def matching_indexes(str, target)
    (0..str.length-1).select { |i| str[i] == target}
  end

end

#gets a code word at random from word_list.txt 
class WordMaster
  attr_reader :code_word

  def initialize
    @code_word = ''
  end

  #chooses code word from word_list
  def choose_code_word
    dictionary = []
    File.readlines("word_list.txt").each do |word|
      if word.length > 4 && word.length < 13
        dictionary.push(word.strip.downcase)
      end
    end
    @code_word = dictionary[rand(dictionary.length)]
  end
end

#gets guesses from user
class WordGuesser
  attr_reader :guess

  def initialize
    @guess = ''
  end

  #gets new letter guess from user
  def get_new_letter
    loop do
      puts "What letter would you like to guess?"
      @guess = gets.chomp.downcase
      break if valid_letter?(@guess)
    end
  end

  #checks if user input is only a single letter
  def valid_letter?(input)
    input.length == 1 && input.match?(/^[[:alpha:]]+$/)
  end
end

m = WordMaster.new
m.choose_code_word
p m.code_word