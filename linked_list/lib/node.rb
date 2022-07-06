class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

