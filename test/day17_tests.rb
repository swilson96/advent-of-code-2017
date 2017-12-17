require 'test/unit'

require_relative '../day17'

class Day17Tests < Test::Unit::TestCase

  def setup
    @test_input = 3
    @real_input = 345
  end

  def test_from_q_v_simple
    spinner = Spinner.new(@test_input)
    assert_equal(1, spinner.solve(3))
  end

  def test_from_q_simple
    spinner = Spinner.new(@test_input)
    assert_equal(5, spinner.solve(9))
  end

  def test_from_q
    spinner = Spinner.new(@test_input)
    assert_equal(638, spinner.solve(2017))
  end


  def test_solve_real
    spinner = Spinner.new(@real_input)

    puts ""

    puts "Answer:"
    puts spinner.solve 2017

  end
end