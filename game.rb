require 'pry'

#plays game
class Game

end

#gets a code word at random from word_list.txt 
class WordMaster
  attr_reader :code_word

  def initialize
    @code_word = ''
  end

  #chooses code word from word_list
  def choose_code_word

  end
end

#gets guesses from user and compares guesses to master word
class WordGuesser
  attr_reader :guess, :good_guesses, :bad_guesses

  def initialize(code_word)
    @code_word = code_word
    @guess = ''
    @good_guesses = Array.new(@code_word.length, '_')
    @bad_guesses = []
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

  #saves guess to appropriate array
  def save_guess
    if good_guess?
      matching_indexes(@code_word, @guess).each do |i|
        @good_guesses[i] = @guess
      end
    else
      @bad_guesses.push(@guess)
    end
  end  
  
  #checks if guess is good
  def good_guess?
    @code_word.include?(@guess)
  end

  #returns array of all matching indexes for 
  def matching_indexes(str, target)
    (0..str.length-1).select { |i| str[i] == target}
  end

end

pl = WordGuesser.new('hello')
pl.get_new_letter
pl.save_guess
p pl.good_guesses
p pl.bad_guesses
