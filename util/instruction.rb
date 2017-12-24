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
      when 'sub'
        state.subtract @X, @Y
      when 'mul'
        state.mul @X, @Y
      when 'mod'
        state.mod @X, @Y
      when 'rcv'
        state.recover @X
      when 'jgz'
        state.jump_if_greater @X, @Y
      when 'jnz'
        state.jump_if_non_zero @X, @Y
      else
        puts "UNRECOGNISED INSTRUCTION: #{to_s}"
    end
  end

  def to_s
    "#{@type} #{@X}#{@Y.nil? ? '' : " #{@Y}"}"
  end

end

class State
  attr_accessor :registers, :fine, :next_instruction, :last_recovered_frequency, :multiplications

  def initialize program_id, debug=true
    @program_id = program_id
    @registers = [['p', program_id]].to_h
    @next_instruction = 0
    @queue = Queue.new
    @partner = nil
    @waiting = false
    @values_sent = 0
    @multiplications = 0
    unless debug
      @registers['a'] = 1
    end
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
    puts "SET H!" if reg == 'h'
    @registers[reg] = (get_val val)
    move_to_next
  end

  def add reg, val
    initialise_reg reg
    @registers[reg] += (get_val val)
    move_to_next
  end

  def subtract reg, val
    initialise_reg reg
    @registers[reg] -= (get_val val)
    move_to_next
  end

  def mul reg, val
    initialise_reg reg
    @registers[reg] *= (get_val val)
    @multiplications += 1
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

  def jump_if_greater val, offset
    # puts "#{}: JUMP! #{val} #{offset}"
    if (get_val val) > 0
      @next_instruction += (get_val offset)
    else
      move_to_next
    end
  end

  def jump_if_non_zero val, offset
    # puts "#{}: JUMP! #{val} #{offset}"
    offset_val = get_val offset
    # print if offset_val < 0
    if (get_val val) != 0
      @next_instruction += offset_val
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
    "#{@registers} : next_instruction: #{@next_instruction}"
  end

  def print
    puts to_s
  end
end
