require "./players.rb"
require "./move.rb"
require "./board.rb"

class Game
  @@CODE_PEGS = (1..6).to_a
  @@KEY_PEGS = ["B", "W"]

  def Game.get_mode
    print "Do you want to be the codebreaker? [Y/n]: "
    choice = gets.chomp.downcase
    !(choice == "n" || choice == "no")
  end

  def initialize
    @board = Board.new
    @codebreaker = nil
    @codemaker = nil
  end

  def playRound
    @board.display(false)
    move = @codebreaker.move
    @board.make_move(move)
    @codebreaker.add_evaluation(@board.evaluations.last)
  end

  def playGame
    human_is_codebreaker = Game.get_mode
    if human_is_codebreaker
      @codebreaker = Human.new
      @codemaker = Computer.new
      puts "Enter move (4 integers, between 1 and 6, with a space between each)"
    else
      @codebreaker = Computer.new
      @codemaker = Human.new
      puts "Choose the hidden pegs (4 integers, between 1 and 6, with a space between each)"
    end
    @board.hidden = @codemaker.choose_hidden
    12.times do
      playRound
      if @board.is_won?
        break
      end
    end
    @board.display(true)
    if @board.is_won?
      puts "The codebreaker, #{@codebreaker.name}, won"
    else
      puts "The codemaker, #{@codemaker.name}, won"
    end
  end
end

mastermind = Game.new
mastermind.playGame
