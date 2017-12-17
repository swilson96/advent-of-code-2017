require 'set'

class Layer
  UP = 0
  DOWN = 1

  def initialize(input)
    words = input.split(/\W+/)
    #puts "#{input} parsed to: #{words.join(',')}"
    @depth = words[0].to_i
    @range = words[1].to_i
    @position = 0
    @direction = UP
  end

  def position
    @position
  end

  def depth
    @depth
  end

  def range
    @range
  end

  def period
    @range * 2 - 2
  end

  def severity
    (@range * @depth)
  end

  def catch?
    @position == 0
  end

  def move
    return 0 if @range <= 1

    @direction = DOWN if @position == (@range - 1) # 0-indexed range to patrol
    @direction = UP if @position == 0
    @position += 1 if @direction == UP
    @position -= 1 if @direction == DOWN
  end

  def reset
    @position = 0
    @direction = UP
  end
end

class Day13
  def initialize(input)
    @layers = input.lines
                  .map {|l| Layer.new(l)}
                  .map {|l| [l.depth, l]}
                  .to_h

    puts "layers #{@layers.size}: deepest: #{@layers.keys.max}"
    # puts "#{(0..@layers.keys.max).map {|i| @layers.key?(i) ? @layers[i].range.to_s : "." }.join(" ")} <-- RANGES"

  end

  def move
    @layers.each { |k,l| l.move }
  end

  def reset
    @layers.each { |k,l| l.reset }
    @caught = -1
  end

  def output position
    puts "#{(0..@layers.keys.max).map {|i| @layers.key?(i) ? @layers[i].position.to_s : "." }.join(" ")} pos: #{position}"
  end

  def traverse start_time, stop_if_caught = false
    position = -1
    time = 0
    @caught = -1

    while time < start_time
      move
      time += 1
    end

    severity = 0

    while position < @layers.keys.max
      # you move!
      position += 1

      # output position

      if @layers.key?(position) && @layers[position].catch?
        @caught = position
        severity += @layers[position].severity
        return severity if stop_if_caught
      end

      # they move!
      move

      # output position

      time += 1
    end

    # puts "time: #{time}, position: #{position}, severity: #{severity}"

    severity
  end

  def find_delay
    max = find_period
    found = false
    candidate = 0

    while !found && candidate < max
      candidate += 1
      found = true
      @layers.each do |k,l|
        if (candidate + l.depth) % l.period == 0
          found = false
          break
        end
      end
    end
    candidate
  end

  def find_period
    @layers.map {|k,l| l.period }.reduce(1, :lcm)
  end
end

