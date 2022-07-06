require_relative "node.rb"

class LinkedList
  attr_reader :head, :tail, :size
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)
    unless @head == nil
      new_node.next_node = @head
    end
    @head = new_node
    @size += 1
  end

  def at(index)
    count = 0
    current_node = @head
    while count < index do
      if current_node == nil
        return nil
      end
      current_node = current_node.next_node
      count += 1
    end
    current_node
  end

  def pop
    if @head == nil
      return nil
    end
    current_node = @head
    until current_node.next_node == @tail do
      current_node = current_node.next_node
    end
    old_tail = current_node.next_node
    current_node.next_node = nil
    @size -= 1
    @tail = current_node
    old_tail
  end

  def contains?(value)
    if @head == nil
      return false
    end
    current_node = @head
    until current_node == nil do
      if current_node.value == value
        return true
      end
      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    if @head == nil
      return nil
    end
    count = 0
    current_node = @head
    until current_node == nil do
      if current_node.value == value
        return count
      end
      current_node = current_node.next_node
      count += 1
    end
    nil
  end

  def to_s
    output = ""
    current_node = @head
    until current_node == nil
      output += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    output += "nil"
  end

  # Extra credit
  def insert_at(value, index)
    if index == 0
      prepend(value)
    elsif index == @size
      append(value)
    elsif index.between?(1, @size - 1)
      new_node = Node.new(value)
      current_node = at(index - 1)
      new_node.next_node = current_node.next_node
      current_node.next_node = new_node
      @size += 1
    else
      nil
    end
  end

  def remove_at(index)
    if index == 0
      @head = @head.next_node
    elsif index == @size
      pop
    elsif index.between?(1, @size - 1)
      current_node = at(index - 1)
      current_node.next_node = current_node.next_node.next_node
      @size -= 1
    else
      nil
    end
  end
end

# TESTS
my_linked_list = LinkedList.new
my_linked_list.append("Jeff")
my_linked_list.prepend("My name")
my_linked_list.prepend("bru")
my_linked_list.prepend("asd")
my_linked_list.append("ruby is pruby is poo")
puts my_linked_list
my_linked_list.insert_at("moist", 2)
puts my_linked_list
my_linked_list.remove_at(4)
puts my_linked_list
p my_linked_list.head.value
p my_linked_list.tail.value
puts my_linked_list.size

