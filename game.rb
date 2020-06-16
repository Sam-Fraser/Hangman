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
  attr_reader :guess, :past_guesses

  def initialize(code_word)
    @code_word = code_word
    @guess = ''
    @past_guesses = []
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

  def save_letter(letter)
    @past_guesses.push(letter)
  end

end

pl = WordGuesser.new('hi')
pl.get_new_letter
pl.save_letter(pl.guess)
p pl.past_guesses