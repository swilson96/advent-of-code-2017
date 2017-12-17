require_relative "./stopwatch.rb"

class Node
  attr_accessor :value, :next

  def initialize(value, next_node)
    @value = value
    @next = next_node
  end
end

class Spinner
  def initialize(input)
    @step_size = input
    @next_value = 1

    @head = Node.new(0, nil)
    @head.next = @head
    @current_node = @head
  end

  def solve spins
    spins.times do
      spin
    end
    @current_node.next.value
  end

  def spin
    @step_size.times do
      @current_node = @current_node.next
    end
    insert
    @next_value += 1
  end

  def insert
    new_node = Node.new(@next_value, @current_node.next)
    @current_node.next = new_node
    @current_node = new_node
  end

  def new_solve spins
    watch = Stopwatch.new
    spins.times do
      spin
      puts "#{@next_value * 100.0/spins}% complete in #{watch.seconds}s" if @next_value % 500000 == 0
    end
    @head.next.value
  end
end

