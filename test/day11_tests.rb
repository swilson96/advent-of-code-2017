require 'test/unit'

require_relative '../day11'

class Day11Tests < Test::Unit::TestCase

  def test_pass
    assert(true, 'Assertion was false.')
  end

  def test_mod_1
    assert_equal(0, mod(0,0))
  end

  def test_shortest_1
    assert_equal(4, shorten("ne,n,ne,n"))
  end
end