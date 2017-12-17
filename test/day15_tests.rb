require 'test/unit'

require_relative '../day15'

class Day15Tests < Test::Unit::TestCase

  def setup
    @test_solver = Day15.new(65, 8921)
  end

  def test_from_q_round_1
    @test_solver.generate
    assert_equal(1092455, @test_solver.a)
    assert_equal(430625591, @test_solver.b)
  end

  def test_from_q_round_2
    @test_solver.generate
    @test_solver.generate
    assert_equal(1181022009, @test_solver.a)
    assert_equal(1233683848, @test_solver.b)
  end

  def test_from_q_round_3
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(245556042, @test_solver.a)
    assert_equal(1431495498, @test_solver.b)
  end

  def test_from_q_round_4
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(1744312007, @test_solver.a)
    assert_equal(137874439, @test_solver.b)
  end

  def test_from_q_round_5
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(1352636452, @test_solver.a)
    assert_equal(285222916, @test_solver.b)
  end

  def test_judge_from_q_round_1
    @test_solver.generate
    assert_false(@test_solver.judge)
  end

  def test_judge_from_q_round_2
    @test_solver.generate
    @test_solver.generate
    assert_false(@test_solver.judge)
  end

  def test_judge_from_q_round_3
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_true(@test_solver.judge)
  end

  def test_judge_from_q_round_4
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_false(@test_solver.judge)
  end

  def test_judge_from_q_round_5
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_false(@test_solver.judge)
  end

  def test_solve_q
    assert_equal(588, @test_solver.solve)
  end

  def test_solve_real
    solver = Day15.new(722, 354)

    puts ""

    puts "Answer:"
    puts solver.solve
  end
end