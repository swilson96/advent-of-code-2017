require_relative 'util/instruction'

class CoProcessor
  def initialize(program_id, input, debug=true, timeout=40000)
    @program_id = program_id
    @instructions = input.lines.map {|l| Instruction.new(l)}
    @state = State.new program_id, debug
    @timeout = timeout
    @timed_out = false
  end

  def output text
    puts "program #{@program_id}: #{text}"
  end

  def play
    counter = 0
    while counter < @timeout && @instructions.length > @state.next_instruction && @state.next_instruction >= 0
      puts "BACK AT START!!!" if (counter > 8 && @state.next_instruction < 2)

      instruction = @instructions[@state.next_instruction]
      instruction.act(@state)
      # output("#{@state}: #{@instructions[@state.next_instruction]}")
      counter += 1
    end
    if counter >= @timeout
      output "timed out!"
      @timed_out = true
    end
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

  def multiplications
    @state.multiplications
  end

  def value_of_h
    @state.registers['h']
  end

  def value_of_b
    output 'whats b?'
    output @state.registers
    @state.registers["b"]
  end

  def value_of_g
    @state.registers["g"]
  end

  def value_of_c
    @state.registers["c"]
  end

  def print
    @state.print
  end
end

def do_it(debug=true)
  mul = 0
  h = 0

  # set b 57
  # set c b
  # jnz a 2
  # jnz 1 5
  if debug
    b = 57
    c = 57
  else
    # mul b 100
    # sub b -100000
    # set c b
    # sub c -17000

    b = 105700
    c = 122700
  end

  loop do # 1000 of these, b heading down to c in increments of 17
    # set f 1
    f = 1
    # set d 2
    d = 2
    while d <= Math.sqrt(b)
      # set e 2
      # e = 2
      # (loop) do
      #   # set g d
      #   # mul g e
      #   # sub g b
      #   # jnz g 2
      #   # set f 0
      #   mul += 1
      #   f = 0 if d*e == b
      #
      #   # sub e -1
      #   e += 1
      #
      #   # set g e
      #   # sub g b
      #   # jnz g -8
      #   break if e == b
      # end

      # the above looks for d being a factor of b
      if b % d == 0
        f = 0
        break
      end

      # sub d -1
      d += 1

      # set g d
      # sub g b
      # jnz g -13
      # break if d == b
    end

    # jnz f 2
    # sub h -1
    h += 1 if f == 0

    # set g b
    # sub g c
    # jnz g 2
    # jnz 1 3
    break if b == c

    # sub b -17
    b += 17

  # jnz 1 -23
  end

  [mul,h]
end
