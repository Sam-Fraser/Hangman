require 'pry'

#plays game
class Game

  def initialize
    @word_master = WordMaster.new
    @word_guesser = WordGuesser.new
    @tries = 0
    @code_word = ''
    @good_guesses = []
    @bad_guesses = []
  end

  #plays game
  def play_game
    #ask user if they want to play a new game or load a save
    print "Would you like to play a new game? (y/n) "
    new_game = gets.chomp.downcase
    print "\n"
    if new_game == "y"
      play_new_game
    else
      load_game
    end
  end

  #starts a new game
  def play_new_game
    #get new code word
    @word_master.choose_code_word
    @code_word = @word_master.code_word
    @good_guesses = Array.new(@code_word.length, '_')
    #tells you rules
    puts "Try to figure out the word. If you guess 5 wrong letters, you lose!"
    #starts playing
    game_loop
  end

  #continues loaded game
  def continue_game(code_word, good_guesses, bad_guesses, tries)

  end

  #saves game to finish later
  def save_game

  end

  #loads unfinished game
  def load_game
    #lists all save files

    #asks which save file user would like to load
    puts "Which save file would you like to load? (type name here)"
    save_file = gets.chomp.downcase

    #loads save file

    #continues game
    continue_game()
  end

  #basic game loop
  def game_loop
    loop do 
      #tells you how many tries you have left
      puts "You have #{5-@tries} bad guesses left."
      #get guess from player
      @word_guesser.get_new_letter
      #saves guess to appropriate array
      save_guess
      #increases tries unless the guess was good
      @tries += 1 unless good_guess?
      if win?
        puts "Congrats! You Win! The word was #{@code_word}"
        break
      elsif @tries == 5
        puts "Shucks! You lost. The word was #{@code_word}"
        break
      end
      puts "Bad Guesses:  #{@bad_guesses.join(', ')}"
      puts "Current Word: #{@good_guesses.join('')}"
    end
  end

  #saves guess to appropriate array
  def save_guess
    if good_guess?
      matching_indexes(@code_word, @word_guesser.guess).each do |i|
        @good_guesses[i] = @word_guesser.guess
      end
    else
      @bad_guesses.push(@word_guesser.guess)
    end
  end  
  
  #checks if guess is good
  def good_guess?
    @code_word.include?(@word_guesser.guess)
  end

  #returns array of all matching indexes for 
  def matching_indexes(str, target)
    (0..str.length-1).select { |i| str[i] == target}
  end

  #checks if you've won
  def win?
    @code_word == @good_guesses.join('')
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

g = Game.new
g.play_new_game