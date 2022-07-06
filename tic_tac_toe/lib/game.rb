require "./player.rb"
require "./move.rb"
require "./board.rb"

class Game
  @@MARKERS = ["X", "O"]

  def Game.get_players()
    players = {}
    for i in 0..1 do
      print "Enter name: "
      name = gets.chomp
      marker = @@MARKERS[i]
      players[marker] = Player.new(name)
      puts "Player #{name} added with marker #{marker}"
    end
    players
  end

  def Game.get_move()
    begin
      move = gets.chomp.split
      raise "Wrong number of arguments" unless move.length == 2
      raise "Arguments are too long" unless move.all? { |str| str.length == 1 }
      raise "Arguments are not integers" unless move.all? { |str| str.ord.between?(48, 57) }
      move = move.map { |str| str.to_i }
      raise "Arguments are not in range (0-2)" unless move.all? { |i| i.between?(0, 2) }

      move = Move.new(move[0], move[1])
      return move
    rescue StandardError=>e
      puts "#{e}, try again..."
      retry
    end
  end

  def initialize()
    @players = Game.get_players()
    @board = Board.new
    @winner = nil
  end

  def playRound(current_turn)
    begin
      move = Game.get_move()
      @board.make_move(move, current_turn)
      puts "#{current_turn} was placed at #{move}"
    rescue StandardError=>e
      puts "#{e}, try again..."
      retry
    end
    @board.display
    if @board.is_won?
      puts "#{@players[current_turn].name} is the winner!"
      @winner = @players[current_turn]
    end
  end

  def playGame
    @board.display
    puts "Enter move (two integers with a space between): "

    turn_counter = 0
    until @winner do
      playRound(@@MARKERS[turn_counter % 2])
      turn_counter += 1
    end
  end
end

my_game = Game.new
my_game.playGame
