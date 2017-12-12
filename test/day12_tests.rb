require 'test/unit'

require_relative '../day12'

class Day12Tests < Test::Unit::TestCase
  @solver


  def setup
    @solver = Day12.new
  end

  def test_trivial
    input = "0 <-> 0"
    assert_equal(1, @solver.size_of_group_zero(input))
  end

  def test_pair
    input = "0 <-> 1
1 <-> 0"
    assert_equal(2, @solver.size_of_group_zero(input))
  end

  def test_from_q
    input = "0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"
    assert_equal(6, @solver.size_of_group_zero(input))
  end

  def test_one_group
    input = "0 <-> 0"
    assert_equal(1, @solver.count_groups(input))
  end

  def test_one_bigger_group
    input = "0 <-> 1
1 <-> 0"
    assert_equal(1, @solver.count_groups(input))
  end

  def test_two_groups
    input = "0 <-> 0
1 <=> 1"
    assert_equal(2, @solver.count_groups(input))
  end

  def test_count_groups_from_q
    input = "0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"
    assert_equal(2, @solver.count_groups(input))
  end

  def test_solve_real
    $realInput = File.open("inputs/day12.txt").read
    puts ""
    puts "The answer:"
    puts @solver.size_of_group_zero($realInput)
    puts @solver.count_groups($realInput)
  end
end