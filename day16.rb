class Step
  def initialize(serialised_step, party_size)
    @party_size = party_size
    @serialised_step = serialised_step.clone
    @type = serialised_step.split(//)[0]
    serialised_step[0] = ''

    if @type == 's'
      @spin = serialised_step.to_i
    else
      chars = serialised_step.split(/\//)
      @a = chars[0]
      @b = chars[1]
    end
  end

  def apply state
    case @type
      when 's'
        spin_size = @spin
        remainder = @party_size - spin_size
        state = state.last(spin_size) + state.take(remainder)
      when 'x'
        a = state[@a.to_i]
        b = state[@b.to_i]
        state[@a.to_i] = b
        state[@b.to_i] = a
      when 'p'
        a_i = state.index(@a)
        b_i = state.index(@b)
        state[a_i] = @b
        state[b_i] = @a
      else
        puts "unknown step! #{serialised_step}"
        exit 1
    end

    puts "#{@serialised_step.rjust(6, ' ')} : #{state.join}"
    state
  end

  def to_s
    @serialised_step
  end

end

class Dance
  def initialize(party_size, steps)
    @party_size = party_size
    @state = ('a'..'z').take(@party_size).to_a
    @steps = steps.split(/,/).map { |s| Step.new s, party_size }
  end

  def execute
    @steps.each do |step|
      @state = step.apply(@state)
    end
    @state.join
  end
end

