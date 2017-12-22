require_relative './util/direction'
require_relative './util/point'

class Virus

  def initialize(input)
    @direction = Direction::UP
    @position = Point.new 0, 0
    @size = input.lines.size
    @map = input.lines.each_with_index.map{|l,i| [i - @size/2,
      l.chomp.each_char.with_index.map{|char,j| [j-@size/2,char]}.to_h] }.to_h
    @infected = 0
  end

  def expand(y)
    @map[y] = Hash.new unless @map.has_key?(y)
  end

  def infected?(point)
    expand(point.y)
    @map[point.y][point.x] == '#'
  end

  def infect(point)
    expand(point.y)
    @map[point.y][point.x] = '#'
    @infected += 1
  end

  def disinfect(point)
    expand(point.y)
    @map[point.y][point.x] = '.'
  end

  def burst
    if infected?(@position)
      @direction = Direction::turn_right(@direction)
    else
      @direction = Direction::turn_left(@direction)
    end

    if infected?(@position)
      disinfect(@position)
    else
      infect(@position)
    end

    @position = @position.move(@direction, 1)
  end

  def count
    @map.values.inject(0){|acc, row| acc + row.values.inject(0){|inner_acc, char| inner_acc + (char == '#' ? 1 : 0)}}
  end

  def print_row row
    print_radius = 50
    (-print_radius..print_radius).each do |i|
      print ' '
      print row.has_key?(i) ? row[i] : '.'
    end
    puts ''
  end

  def print_map
    Hash[@map.sort].each do |k,v|
      print_row v
    end
  end

  def spread(bursts)
    (1..bursts).each do |burst_index|
      # puts "turn: #{burst_index} direction: #{Direction::print @direction}, position: #{@position}, char: #{@map[@position.y][@position.x]}, infected? #{infected? @position}"
      # print_map
      burst
    end

    # puts "after #{bursts} bursts"
    # print_map

    @infected
  end

end