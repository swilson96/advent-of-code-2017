class Direction
  #      ^         y == 0
  #      3         y == 1
  # <- 2   0 ->    y == 2
  #      1
  #      \/
  RIGHT = 0
  DOWN = 1
  LEFT = 2
  UP = 3

  def self.turn_right(direction)
    (direction + 1) % 4
  end

  def self.turn_left(direction)
    (direction - 1) % 4
  end

  def self.print(direction)
    case direction
      when Direction::RIGHT
        'RIGHT'
      when Direction::UP
        'UP'
      when Direction::DOWN
        'DOWN'
      when Direction::LEFT
        'LEFT'
      else
        "UNKNOWN: #{direction}"
    end
  end
end