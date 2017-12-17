require 'test/unit'

require_relative '../day14'

class Day14Tests < Test::Unit::TestCase

  def setup
    @test_input = "flqrgnkx"
    @real_input = "uugsqrei"
  end

  def test_trivial
    input = "00000000"
    solver = Day14.new(input)
    # reverse engineered (black box test to avoid regression)
    assert_equal(8198, solver.count)
  end

  def test_from_q
    solver = Day14.new(@test_input)
    assert_equal(8108, solver.count)
  end

  def test_regions_from_q
    solver = Day14.new(@test_input)
    assert_equal(1242, solver.count_regions)
  end

  def test_solve_real
    solver = Day14.new(@real_input)

    puts ""

    puts "Used locations:"
    puts solver.count

    puts "Number of regions:"
    puts solver.count_regions
  end
end