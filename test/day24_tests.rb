require 'test/unit'

require_relative '../day24'

class Day23Tests < Test::Unit::TestCase

  TEST_INPUT = '0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10'

  REAL_INPUT = File.open("inputs/day24.txt").read

  def test_from_q
    strongest = strongest(TEST_INPUT)
    assert_equal(31, strongest)
  end

  def test_part_1
    strongest = strongest(REAL_INPUT)
    assert_equal(1868, strongest)
  end

  def test_part_2_from_q
    longest = longest(TEST_INPUT)
    assert_equal(19, longest)
  end

  def test_part_2
    longest = longest(REAL_INPUT)
    puts ''
    puts "ANSWER part 2: #{longest}"
  end

end
