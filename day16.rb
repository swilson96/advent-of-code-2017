require_relative './stopwatch.rb'

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

    # puts "#{to_s.rjust(6, ' ')} : #{state.join}"
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

  def execute_from_scratch
    @steps.each do |step|
      @state = step.apply(@state)
    end
    @state.join
  end

  def execute positions
    state = positions.clone
    @steps.each do |step|
      state = step.apply(state)
    end
    state
  end

  Blank = ('a'..'p').to_a
  
  def find_period
    period = 1
    state = execute Blank
    while state != Blank
      state = execute state
      period += 1
    end
    period
  end

  One_billion = 1000000000

  def one_billion
    watch = Stopwatch.new
    state = Blank
    times_to_do = One_billion % find_period
    puts "only need to execute it #{times_to_do} times!"
    (1..times_to_do).each do |time|
      state = execute state
      # puts "#{time}: #{state.join}"
      # puts "#{time * 100.0/times_to_do}% complete in #{watch.seconds}s" if time % 5000000 == 0
    end
    state.join
  end
end

class Permutation
  def initialize(input)
    @permutation = input.split(//).map{|char| ('a'..'z').to_a.index(char) }
  end

  def apply array
    @permutation.map{|i| array[i]}
  end

  def find_period
    period = 1
    state = apply Blank
    while state != Blank
      state = apply state
      period += 1
      puts period if period % 1000000 == 0
    end
    period
  end

  Blank = (0..15).to_a
  One_billion = 1000000000

  def one_billion
    watch = Stopwatch.new
    state = Blank
    times_to_do = One_billion % find_period
    puts "only need to apply it #{times_to_do} times!"
    (1..times_to_do).each do |time|
      state = apply state
      # puts "#{time}: #{state.map {|i| ('a'..'z').to_a[i]}.join}"
      # puts "#{time * 100.0/times_to_do}% complete in #{watch.seconds}s" if time % 5000000 == 0
    end
    state.map {|i| ('a'..'z').to_a[i]}.join
  end
end
