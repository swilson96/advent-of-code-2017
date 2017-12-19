require 'test/unit'

require_relative '../day19'

class Day19Tests < Test::Unit::TestCase

  TEST_INPUT =
'     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+'

  REAL_INPUT = File.open("inputs/day19.txt").read

  def test_points_equal
    assert_equal(Point.new(123,6), Point.new(123,6))
  end

  def test_find_start
    robot = Robot.new TEST_INPUT
    position = robot.find_start
    assert_equal(5, position.x)
    assert_equal(0, position.y)
  end

  def test_from_q
    robot = Robot.new TEST_INPUT
    robot.solve
    assert_equal('ABCDEF', robot.found)
  end

  def test_from_q_part_2
    robot = Robot.new TEST_INPUT
    moves = robot.solve
    assert_equal(38, moves)
  end

  def test_solve_part_2
    robot = Robot.new REAL_INPUT
    moves = robot.solve

    puts ''
    puts 'Answer:'
    puts robot.found
    puts "in #{moves} moves"
  end

end