require 'yaml'

class Hangman
  NUMBER_ROUNDS = 14

  def Hangman.from_yaml(filename)
    data = YAML.load_file(filename)
    Hangman.new(data[:secret], data[:correct_letters], data[:wrong_letters])
  end

  def Hangman.select_random_word(filename)
    line_count = %x{wc -l #{filename}}.split.first.to_i
    word_file = File.open(filename, 'r')
    loop do
      rand(line_count).times do
        word_file.readline
      end
      word = word_file.readline.chomp.split('')
      if word.length.between?(5, 12)
        word_file.close
        return word
      else
        word_file.rewind
      end
    end
  end

  def Hangman.start
    print 'Do you want to load a previous game? [Y/n]: '
    user_input = gets.chomp.downcase
    if user_input == 'n'
      game = Hangman.new
    else
      game = Hangman.from_yaml("savedata")
    end
    game.play
  end

  def initialize(
    secret = nil,
    correct_letters = nil,
    wrong_letters = nil
  )
    if secret.nil?
      @secret = Hangman.select_random_word('google-10000-english-no-swears.txt')
    else
      @secret = secret
    end

    if correct_letters.nil?
      @correct_letters = Array.new(@secret.length) { '-' }
    else
      @correct_letters = correct_letters
    end

    if wrong_letters.nil?
      @wrong_letters = Array.new
    else
      @wrong_letters = wrong_letters
    end

    @is_won = false
    @is_over = false
  end

  def to_yaml
    YAML.dump ({
      :secret => @secret,
      :correct_letters => @correct_letters,
      :wrong_letters => @wrong_letters
    })
  end

  def save_to_file
    File.open("savedata", "w"){ |file| file.puts(to_yaml) }
  end

  def evaluate_guess(letter)
    if @secret.include?(letter)
      @secret.each_with_index do |value, index|
        if value == letter
          @correct_letters[index] = letter
        end
      end
    else
      @wrong_letters.push(letter)
    end

    if @wrong_letters.length >= NUMBER_ROUNDS
      @is_over = true
    end

    if @correct_letters == @secret
      @is_won = true
    end
  end

  def make_guess
    loop do
      print "Enter letter (or write \"save\"): "
      user_input = gets.chomp.downcase
      if user_input == 'save'
        save_to_file
        puts "Save complete, exiting..."
        exit
      elsif user_input.length != 1
        puts 'The guess is too long, try again...'
      elsif @wrong_letters.include?(user_input)
        puts 'This is a repeated guess, try again...'
      else
        evaluate_guess(user_input)
        puts "Correct guesses: #{@correct_letters.join(' ')}"
        puts "Incorrect guesses: #{@wrong_letters.join(', ')}"
        puts "Incorrect guesses remaining: #{NUMBER_ROUNDS - @wrong_letters.length}\n\n"
        break
      end
    end
  end

  def play
    puts @correct_letters.join(' ')
    until @is_over || @is_won
      make_guess
    end
    if @is_won
      print "You won"
    else
      print "You lost"
    end
    print ", the word was #{@secret.join}\n"
  end
end

Hangman.start

