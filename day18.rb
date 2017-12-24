require_relative 'util/instruction'

class Duet
  def initialize(program_id, input)
    @program_id = program_id
    @instructions = input.lines.map {|l| Instruction.new(l)}
    @state = State.new program_id
    @timed_out = false
  end

  def play
    timeout = 0
    while timeout < 4000000
      instruction = @instructions[@state.next_instruction]
      instruction.act(@state)
      # @state.print if @program_id == 1
      timeout += 1
    end
    puts "#{@program_id}: timed out!"
    @timed_out = true
    @state.last_recovered_frequency
  end

  def set_partner partner
    @state.set_partner partner
  end

  def enqueue val
    @state.enqueue val
  end

  def is_waiting
    @state.is_waiting && @state.empty_queue?
  end

  def is_timed_out
    return @timed_out
  end

  def values_sent
    @state.values_sent
  end

  def print
    @state.print
  end
end

class Conductor
  def initialize(input)
    @zero = Duet.new 0, input
    @one = Duet.new 1, input

    @zero.set_partner @one
    @one.set_partner @zero
  end

  def deadlock
    @zero.is_waiting && @one.is_waiting
  end

  def timed_out
    (@zero.is_timed_out && @one.is_timed_out) ||
        @zero.is_timed_out && @one.is_waiting ||
        @one.is_timed_out && @zero.is_waiting
  end

  def play
    one = Thread.new do
      @one.play
    end

    zero = Thread.new do
      @zero.play
    end

    while !deadlock && !timed_out
      puts "Conductor awaiting deadlock"
      @one.print
      sleep 5
    end

    puts "FINISHED!"

    puts "prog 1 sent #{@one.values_sent} values"

    exit 1
  end
end

