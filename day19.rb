#      ^         y == 0
#      3         y == 1
# <- 2   0 ->    y == 2
#      1
#      \/
RIGHT = 0
DOWN = 1
LEFT = 2
UP = 3

require_relative './util/point'

class Robot
  def initialize(maze)
    @changes = maze.scan(/\+/).size
    @letters = maze.scan(/\w/).size

    @grid = maze.lines.map {|l| l.chomp.split(//).to_a}
    @direction = 1
    @position = Point.new 0, 0
    @found = []
    @finished = false

    puts ''
    puts "changes to do: #{@changes}"
    puts "letters to find: #{@letters}"

    # print_grid
  end

  def print_grid
    y = 0
    puts ''
    @grid.each do |row|
      puts "#{y.to_s.rjust(4, ' ')}: #{row.join}"
      y += 1
    end
  end

  def print_direction
    case @direction
      when RIGHT
        'RIGHT'
      when UP
        'UP'
      when DOWN
        'DOWN'
      when LEFT
        'LEFT'
      else
        "UNKNOWN: #{@direction}"
    end
  end

  def look position
    # rows then columns!
    @grid[position.y][position.x]
  end

  def look_here
    look @position
  end

  def find_start
    @position = Point.new 0, 0
    while look_here == ' '
      @position = @position.move(RIGHT, 1)
    end
    @position # return for testing
  end

  def move_and_check
    if !can_move(@direction) || look_around(@direction) == ' '
      @finished = true
    else
      @position = @position.move(@direction, 1)

      if @found.include?(look_here)
        puts "LOOP! unless the letter is at a crossover: #{look_here}"
        exit 1
      end

      @found << look_here unless ['|', '+', '-', ' ', nil].include? look_here

      @direction = find_next_direction if look_here == '+'
    end
  end

  def can_move(direction)
    case direction
      when RIGHT
        @position.x < @grid[@position.y].size - 1
      when DOWN
        @position.y < @grid.size - 1
      when LEFT
        @position.x > 0
      when UP
        @position.y > 0
      else
        puts "UNKNOWN DIRECTION: #{direction}"
        exit 1
    end
  end

  def look_around(direction)
    look @position.move(direction, 1)
  end

  def find_next_direction
    return UP unless @direction == DOWN || !can_move(UP) || (@found + [nil, ' ', '-']).include?(look_around(UP))
    return DOWN unless @direction == UP || !can_move(DOWN) || (@found + [nil, ' ', '-']).include?(look_around(DOWN))
    return RIGHT unless @direction == LEFT || !can_move(RIGHT) || (@found + [nil, ' ', '|']).include?(look_around(RIGHT))
    return LEFT unless @direction == RIGHT || !can_move(LEFT) || (@found + [nil, ' ', '|']).include?(look_around(LEFT))
  end

  def found
    @found.join
  end

  def solve
    find_start
    move = 0
    changes_seen = 0
    @direction = DOWN
    while !@finished && move < 200000
      changes_seen += 1 if look_here == '+'
      # puts "move: #{move}, change: #{changes_seen}, #{@position} symbol: #{look_here}, direction: #{print_direction}" unless ['-', '|'].include? look_here

      move_and_check
      move += 1
    end

    move
  end

end