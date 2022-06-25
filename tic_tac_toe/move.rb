class Move
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def to_s
    "(#{row}, #{col})"
  end
end
