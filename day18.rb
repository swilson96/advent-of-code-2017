class Instruction
  attr_accessor :X, :Y

  def initialize(input)
    words = input.chomp.split(/ /)
    @type = words[0]
    @X = words[1]
    if words.length > 2
      @Y = words[2]
    end
  end

  def act state
    case @type
      when 'snd'
        state.play @X
      when 'set'
        state.set @X, @Y
      when 'add'
        state.add @X, @Y
      when 'mul'
        state.mul @X, @Y
      when 'mod'
        state.mod @X, @Y
      when 'rcv'
        state.recover @X
      when 'jgz'
        state.jump @X, @Y
      else
        puts "UNRECOGNISED INSTRUCTION: #{to_s}"
    end
  end

  def to_s
    "#{@type} #{@X}#{@Y.nil? ? '' : " #{@Y}"}"
  end

end

class State
  attr_accessor :registers, :fine, :next_instruction, :last_recovered_frequency

  def initialize program_id
    @program_id = program_id
    @registers = [['p', program_id]].to_h
    @next_instruction = 0
    @queue = Queue.new
    @partner = nil
    @waiting = false
    @values_sent = 0
  end

  def initialise_reg reg
    @registers[reg] = 0 unless @registers.key? reg
  end

  def play val
    val = get_val val
    @partner.enqueue val if !@partner.nil?
    puts "#{@program_id}: SENT #{val}"
    @values_sent += 1
    move_to_next
  end

  def get_val val
    if val.to_i.to_s == val
      val.to_i
    else
      initialise_reg val
      @registers[val]
    end
  end

  def set reg, val
    @registers[reg] = (get_val val)
    move_to_next
  end

  def add reg, val
    initialise_reg reg
    @registers[reg] += (get_val val)
    move_to_next
  end

  def mul reg, val
    initialise_reg reg
    @registers[reg] *= (get_val val)
    move_to_next
  end

  def mod reg, val
    initialise_reg reg
    @registers[reg] = @registers[reg] % (get_val val)
    move_to_next
  end

  def recover reg
    while @queue.empty?
      @waiting = true
      puts "#{@program_id}: waiting..."
      sleep 1
    end
    @waiting = false
    @registers[reg] = @queue.pop
    puts "#{@program_id}: RECEIVED #{@registers[reg]}"
    move_to_next
  end

  def is_waiting
    @waiting
  end

  def jump val, offset
    # puts "#{}: JUMP! #{val} #{offset}"
    if (get_val val) > 0
      @next_instruction += (get_val offset)
    else
      move_to_next
    end
  end

  def move_to_next
    @next_instruction += 1
  end

  def set_partner partner
    @partner = partner
  end

  def enqueue val
    @queue << val
  end

  def values_sent
    @values_sent
  end

  def empty_queue?
    @queue.empty?
  end

  def to_s
    "#{@program_id}: #{@registers} : next_instruction: #{@next_instruction}"
  end

  def print
    puts to_s
  end
end

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

