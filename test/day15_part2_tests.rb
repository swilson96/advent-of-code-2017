require 'test/unit'

require_relative '../day15'

class Day15Tests < Test::Unit::TestCase

  def setup
    @test_solver = Day15_part2.new(65, 8921)
  end

  def test_from_q_round_1
    @test_solver.generate
    assert_equal(1352636452, @test_solver.a)
    assert_equal(1233683848, @test_solver.b)
  end

  def test_from_q_round_2
    @test_solver.generate
    @test_solver.generate
    assert_equal(1992081072, @test_solver.a)
    assert_equal(862516352, @test_solver.b)
  end

  def test_from_q_round_3
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(530830436, @test_solver.a)
    assert_equal(1159784568, @test_solver.b)
  end

  def test_from_q_round_4
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(1980017072, @test_solver.a)
    assert_equal(1616057672, @test_solver.b)
  end

  def test_from_q_round_5
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    @test_solver.generate
    assert_equal(740335192, @test_solver.a)
    assert_equal(412269392, @test_solver.b)
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
    assert_false(@test_solver.judge)
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

  def test_judge_from_q_round_1056
    (1..1056).each do
      assert_false(@test_solver.judge)
      @test_solver.generate
    end
    assert_true(@test_solver.judge)
  end

  def test_solve_q
    assert_equal(309, @test_solver.solve)
  end

  def test_solve_real
    solver = Day15_part2.new(722, 354)

    puts ""

    puts "Answer:"
    puts solver.solve
  end
end