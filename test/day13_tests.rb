require 'test/unit'

require_relative '../day13'

class Day12Tests < Test::Unit::TestCase

  def setup
    @question_input = "0: 3
1: 2
4: 4
6: 4"
  end

  def test_trivial
    input = "0:1"
    solver = Day13.new(input)
    assert_equal(0, solver.traverse(0))
  end

  def test_pair
    input = "0:1
1:1"
    solver = Day13.new(input)
    assert_equal(1, solver.traverse(0))
  end

  def test_from_q
    solver = Day13.new(@question_input)
    assert_equal(24, solver.traverse(0))
  end

  def test_from_q_10_passes
    solver = Day13.new(@question_input)
    assert_equal(0, solver.traverse(10))
  end

  def test_part_2_from_q
    solver = Day13.new(@question_input)
    assert_equal(10, solver.find_delay)
  end

  def test_solve_real
    realInput = File.open("inputs/day13.txt").read
    solver = Day13.new(realInput)
    puts ""
    puts "period: #{solver.find_period}"
    puts "The answer:"
    puts solver.traverse(0)
    puts solver.find_delay
  end
end