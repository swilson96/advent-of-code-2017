require 'test/unit'

require_relative '../day16'

class Day16Tests < Test::Unit::TestCase

  Test_input = 's1,x3/4,pe/b'

  def test_from_q
    dance = Dance.new 5, Test_input
    assert_equal 'baedc', dance.execute
  end

  def test_solve_part_1
    real_input = File.open("inputs/day16.txt").read

    dance = Dance.new 16,real_input

    puts ""
    puts "Answer part 2:"
    puts dance.execute
  end
end