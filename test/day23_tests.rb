require 'test/unit'

require_relative '../day23'

class Day23Tests < Test::Unit::TestCase

  TEST_INPUT = 'set a 2
jnz b 4
mul b a
set b 2
jnz a -4'

  REAL_INPUT = File.open("inputs/day23.txt").read
  OPT_INPUT = File.open("inputs/day23_mod.txt").read

  def test_from_q
    processor = CoProcessor.new 0, TEST_INPUT
    processor.play
    assert_equal(1, processor.multiplications)
  end

  def test_part_1
    processor = CoProcessor.new 0, REAL_INPUT, true
    processor.play
    assert_equal(3025, processor.multiplications)
  end

  def ignore_test_part_1_new_imp
    result = do_it
    assert_equal(3025, result[0])
  end

  def test_part_2
    processor = CoProcessor.new 0, OPT_INPUT, false
    processor.play
    processor.print

    assert_equal(105700, processor.value_of_b)
    assert_equal(122700, processor.value_of_c)

    puts ''
    puts "ANSWER 1st: #{processor.value_of_h}"
  end

  def test_part_2_new_imp
    result = do_it false

    puts ''
    puts "ANSWER 2nd: #{result[1]}"
  end

end
