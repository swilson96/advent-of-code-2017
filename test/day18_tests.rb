require 'test/unit'

require_relative '../day18'

class Day18Tests < Test::Unit::TestCase

  Test_input = 'set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2'

  Parallel_input = 'snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d'

  Real_input = File.open("inputs/day18.txt").read

  def test_from_q
    conductor = Conductor.new Parallel_input
    # conductor.play
  end

  def test_solve_part_2
    puts ''
    conductor = Conductor.new Real_input
    conductor.play
  end

end