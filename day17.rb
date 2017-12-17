class Spinner
  def initialize(input)
    @step = input
    @current_position = 0
    @next_value = 1
    @state = [0]
  end

  def spin
    @current_position += @step
    @current_position = @current_position % @state.size
    @current_position += 1
    @state.insert(@current_position, @next_value)
    @next_value += 1
  end

  def solve spins
    spins.times do
      spin
    end
    @state[@current_position + 1]
  end

end

