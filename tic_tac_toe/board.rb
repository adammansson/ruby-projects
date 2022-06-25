class Board
  def initialize()
    @matrix = Array.new(3) { Array.new(3) }
  end

  def make_move(move, marker)
    unless @matrix[move.row][move.col]
      @matrix[move.row][move.col] = marker
    else
      raise "That square is occupied"
    end
  end

  def is_won?
    @matrix.each do |row|
      return true if row.first && row.all? { |sq| sq == row.first }
    end
    @matrix.transpose.each do |col|
      return true if col.first && col.all? { |sq| sq == col.first }
    end
    first_diagonal = (0..2).map { |i| @matrix[i][i] }
    if first_diagonal.first
      return true if first_diagonal.all? { |sq| sq == first_diagonal.first }
    end
    second_diagonal = [@matrix[0][2], @matrix[1][1], @matrix[2][0]]
    if second_diagonal.first
      second_diagonal.all? { |sq| sq == second_diagonal.first }
    end
    false
  end

  def display
    @matrix.each_with_index do |row, row_index|
      print "| "
      row.each_with_index do |marker, col_index|
        if marker
          print marker + " | "
        else
          print "  | "
        end
      end
      print "\n"
    end
  end
end
