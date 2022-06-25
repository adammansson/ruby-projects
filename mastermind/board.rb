class Board
  attr_accessor :hidden
  attr_reader :evaluations

  def initialize()
    @board = Array.new(12) { Array.new(4) }
    @hidden = Array.new(4)
    @evaluations = Array.new
    @moves_made = 0
  end

  def make_move(move)
    @board[@moves_made] = move
    evaluate_move(move)
    @moves_made += 1
  end

  def evaluate_move(move)
    move_copy = move.dup
    hidden_copy = @hidden.dup
    evaluation = Array.new
    move.each_with_index do |code_peg, index|
      if code_peg == @hidden[index]
        evaluation.push "B"
        move_copy.delete_at(move_copy.index(code_peg))
        hidden_copy.delete_at(hidden_copy.index(code_peg))
      end
    end
    move_copy.each do |code_peg|
      if hidden_copy.include?(code_peg)
        evaluation.push "W"
        hidden_copy.delete_at(hidden_copy.index(code_peg))
      end
    end
    @evaluations.push(evaluation)
  end

  def is_won?
    @board.last == @hidden
  end

  def display(is_over)
    if is_over 
      puts "\n| #{@hidden.join(" | ")} |\n_________________"
    else
      puts "\n| X | X | X | X |\n_________________"
    end
    @board.reverse.each_with_index do |row, index|
      print "| "
      row.each do |peg|
        if peg
          print peg.to_s + " | "
        else
          print "  | "
        end
      end
      puts "#{@evaluations[11 - index]}"
    end
  end
end
