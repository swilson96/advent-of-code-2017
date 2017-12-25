require 'test/unit'

require_relative '../day25'

class Day25Tests < Test::Unit::TestCase

  def test_part_1
    result = turing
    puts ''
    puts "ANSWER part 1: #{result}"
    assert_equal(2832, result)
  end

end
