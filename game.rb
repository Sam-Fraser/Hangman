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

end
