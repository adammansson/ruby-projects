class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @evaluations = Array.new
  end

  def add_evaluation(evaluation)
    @evaluations.push(evaluation)
  end
end

class Human < Player
  def Human.get_name
    print "Enter name: "
    gets.chomp
  end

  def Human.validate_move(move)
    raise "Wrong number of arguments" unless move.length == 4
    raise "Arguments are too long" unless move.all? { |str| str.length == 1 }
    raise "Arguments are not integers between 1 and 6" unless move.all? { |str| str.ord.between?(49, 54) }
  end

  def initialize()
    super(Human.get_name)
  end

  def choose_hidden
    move
  end

  def move
    begin
      move = gets.chomp.split
      Human.validate_move(move)
      move = move.map { |str| str.to_i }
      return move
    rescue StandardError=>e
      puts "#{e}, try again..."
      retry
    end
  end
end

class Computer < Player
  def initialize()
    super("ThinkPad")
    @guesses = Array.new
    @correct_colors = Array.new
  end

  def choose_hidden
    code_pegs = (1..6).to_a
    Array.new(4).map { |i| i = code_pegs.sample }
  end

  def move
    if @guesses.length == 0
      move = [1, 1, 1, 1]
      @guesses.push(move)
      move
    elsif @guesses.length < 7
      if @guesses.length > 1
        (@evaluations[-1].length - @evaluations[-2].length).times do
          @correct_colors.push(@guesses.length)
        end
      else
        (@evaluations.last.length).times do
          @correct_colors.push(1)
        end
      end
      move = @correct_colors + ([@guesses.length + 1] * (4 - @correct_colors.length))
      @guesses.push(move)
      move
    else
      @correct_colors
    end
  end
end
