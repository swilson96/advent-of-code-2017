require 'test/unit'

require_relative '../day16'

class Day16Tests < Test::Unit::TestCase

  Test_input = 's1,x3/4,pe/b'
  Real_input = File.open("inputs/day16.txt").read

  def test_from_q
    dance = Dance.new 5, Test_input
    assert_equal 'baedc', dance.execute_from_scratch
  end

  def test_solve_part_1
    dance = Dance.new 16,Real_input

    assert_equal('gkmndaholjbfcepi', dance.execute_from_scratch)
  end

  def test_q_part2
    dance = Dance.new 5, Test_input
    state = ('a'..'e').to_a

    state = dance.execute state
    assert_equal('baedc', state.join)

    state = dance.execute state
    assert_equal('ceadb', state.join)
  end

  def test_utils
    blank = (0..15).to_a
    assert_equal('abcdefghijklmnop', blank.map {|i| ('a'..'z').to_a[i]}.join)
  end

  def test_ruby_equals
    state = (0..15).to_a
    perm = Permutation.new 'abcdefghijklmnop'
    assert_equal(state, perm.apply(state))
  end

  def test_part_2_permute_once
    perm = Permutation.new 'gkmndaholjbfcepi'
    array = (0..15).to_a
    result = perm.apply(array)
    puts ''
    puts result.join(' ')
    assert_equal('gkmndaholjbfcepi', result.map {|i| ('a'..'z').to_a[i]}.join)
  end

  def test_zero_period
    perm = Permutation.new 'abcdefghijklmnop'
    assert_equal(1, perm.find_period)
  end

  def test_double_period
    perm = Permutation.new 'bacdefghijklmnop'
    assert_equal(2, perm.find_period)
  end

  def test_triple_period
    perm = Permutation.new 'bcadefghijklmnop'
    assert_equal(3, perm.find_period)
  end


  def test_last_eight_times
    perm = Permutation.new 'gkmndaholjbfcepi'
    state = 'abcndfghijklmeop'.split(//).map{|c| ('a'..'z').to_a.index(c)}
    8.times do
      state = perm.apply state
      # puts state.map {|i| ('a'..'z').to_a[i]}.join
    end
    assert_equal((0..15).to_a, state)
  end

  def test_period
    perm = Permutation.new 'gkmndaholjbfcepi'
    state = (0..15).to_a
    24.times do
      state = perm.apply state
      # puts state.map {|i| ('a'..'z').to_a[i]}.join
    end
    assert_equal((0..15).to_a, state)
  end

  def test_three_times_is_twenty_seven_times
    perm = Permutation.new 'gkmndaholjbfcepi'
    state = (0..15).to_a
    3.times do
      state = perm.apply state
    end

    state2 = (0..15).to_a
    27.times do
      state2 = perm.apply state2
    end

    assert_equal(state, state2)
  end

  def test_sixteen_times_is_forty_times
    perm = Permutation.new 'gkmndaholjbfcepi'
    state = (0..15).to_a
    16.times do
      state = perm.apply state
    end

    state2 = (0..15).to_a
    40.times do
      state2 = perm.apply state2
    end

    assert_equal(state, state2)
  end

  def test_dance_period
    dance = Dance.new 16, Real_input
    state = ('a'..'p').to_a
    60.times do
      state = dance.execute state
      # puts state.map {|i| ('a'..'z').to_a[i]}.join
    end
    assert_equal(('a'..'p').to_a, state)
  end

  def test_part_2
    dance = Dance.new 16, Real_input
    puts ''
    puts 'period:'
    puts dance.find_period

    puts 'doing it...'
    puts dance.one_billion
  end
end