require 'test/unit'

require_relative '../day22'

class Day22Tests < Test::Unit::TestCase

  TEST_INPUT = '..#
#..
...'

  REAL_INPUT = File.open("inputs/day22.txt").read

  def test_from_q_7
    virus = Virus.new(TEST_INPUT)
    infected = virus.spread 7
    assert_equal 5, infected
    assert_equal 5, virus.count
  end

  def test_from_q_70
    virus = Virus.new(TEST_INPUT)
    infected = virus.spread 70
    assert_equal 14, virus.count
    assert_equal 41, infected
  end

  def test_from_q_10k
    virus = Virus.new(TEST_INPUT)
    infected = virus.spread 10000
    assert_equal 5587, infected
  end

  def test_part_1
    virus = Virus.new(REAL_INPUT)
    infected = virus.spread 10000
    assert_equal(5399, infected)
  end

  def test_from_q_part2_7
    virus = Evolved.new(TEST_INPUT)
    infected = virus.spread 7
    assert_equal 1, infected
    assert_equal 2, virus.count
  end

  def test_from_q_part2_100
    virus = Evolved.new(TEST_INPUT)
    infected = virus.spread 100
    assert_equal 26, infected
  end

  def test_part_2
    virus = Evolved.new(REAL_INPUT)
    infected = virus.spread 10000000
    puts ''
    puts "Answer: #{infected}"
  end

end