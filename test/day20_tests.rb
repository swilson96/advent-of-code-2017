require 'test/unit'

require_relative '../day20'
require_relative '../stopwatch'

class Day20Tests < Test::Unit::TestCase

  TEST_INPUT = 'p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0> '

  TEST_PART_2_INPUT = 'p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>'

  REAL_INPUT = File.open("inputs/day20.txt").read

  def test_from_q
    system = System.new TEST_INPUT
    assert_equal(0, system.slowest)
  end

  def test_part_1
    system = System.new REAL_INPUT
    assert_equal(125, system.slowest)
  end

  def test_collision_after_three
    system = System.new TEST_PART_2_INPUT
    assert_equal(4, system.remaining)
    system.tick
    system.remove_collisions
    assert_equal(4, system.remaining)
    system.tick
    system.remove_collisions
    assert_equal(1, system.remaining)
  end

  def test_solve
    watch = Stopwatch.new
    system = System.new REAL_INPUT

    system.remove_collisions
    time = 0
    while !system.all_leaving && time < 5000 do
      system.tick
      system.remove_collisions
      time += 1

      puts "Tick #{time}: #{system.remaining} left, slowest is #{system.slowest} after #{watch.seconds}s" if time % 500 == 0
    end

    puts ''
    puts 'Answer:'
    puts system.slowest
  end

end