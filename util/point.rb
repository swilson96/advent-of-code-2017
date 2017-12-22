require_relative './direction'

class Point
  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def move(direction, distance)
    case direction
      when Direction::RIGHT
        Point.new x + distance, y
      when Direction::DOWN
        Point.new x, y + distance
      when Direction::LEFT
        Point.new x - distance, y
      when Direction::UP
        Point.new x, y - distance
      else
        puts "UNKNOWN DIRECTION: #{direction}"
        exit 1
    end
  end

  def to_s
    "(#{@x},#{@y})"
  end

  def ==(other)
    other.x == @x && other.y == @y
  end
end