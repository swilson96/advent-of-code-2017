def turing
  step = 0
  state = 'A'
  total_steps = 12794428
  cursor = 0
  tape = Hash.new

  while step < 12794428
    val = tape[cursor].nil? ? 0 : tape[cursor]

    case state
    when 'A'
      if val == 0
        tape[cursor] = 1
        cursor += 1
        state = 'B'
      else
        tape[cursor] = 0
        cursor -= 1
        state = 'F'
      end
    when 'B'
      if val == 0
        tape[cursor] = 0
        cursor += 1
        state = 'C'
      else
        tape[cursor] = 0
        cursor += 1
        state = 'D'
      end
    when 'C'
      if val == 0
        tape[cursor] = 1
        cursor -= 1
        state = 'D'
      else
        tape[cursor] = 1
        cursor += 1
        state = 'E'
      end
    when 'D'
      if val == 0
        tape[cursor] = 0
        cursor -= 1
        state = 'E'
      else
        tape[cursor] = 0
        cursor -= 1
        state = 'D'
      end
    when 'E'
      if val == 0
        tape[cursor] = 0
        cursor += 1
        state = 'A'
      else
        tape[cursor] = 1
        cursor += 1
        state = 'C'
      end
    when 'F'
      if val == 0
        tape[cursor] = 1
        cursor -= 1
        state = 'A'
      else
        tape[cursor] = 1
        cursor += 1
        state = 'A'
      end

    else
      puts "Not a state! #{state}"
      exit 1
    end

    step += 1
  end

  tape.values.inject(0) {|sum, val| sum + val }
end
