require 'test/unit'

require_relative '../day21'
require_relative '../stopwatch'

class Day21Tests < Test::Unit::TestCase

  TEST_INPUT = '../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#'

  REAL_INPUT = File.open("inputs/day21.txt").read

  def test_split_4
    twos = split_4_into_2s '.#../..#./###./....'
    assert_equal('.#/..', twos[0][0])
    assert_equal('../#.', twos[0][1])
    assert_equal('##/..', twos[1][0])
    assert_equal('#./..', twos[1][1])
  end

  def test_split_4s
    twos = split_fours [['.#../..#./###./....']]
    assert_equal('.#/..', twos[0][0])
    assert_equal('../#.', twos[0][1])
    assert_equal('##/..', twos[1][0])
    assert_equal('#./..', twos[1][1])
  end

  def test_flatten_art
    assert_equal(['.#','..'], flatten([['.#/..']]))
  end

  def test_grid_art
    twos = grid_art ['.#..','..#.','###.','....']
    assert_equal('.#/..', twos[0][0])
    assert_equal('../#.', twos[0][1])
    assert_equal('##/..', twos[1][0])
    assert_equal('#./..', twos[1][1])
  end

  def test_grid_big_art
    grid = grid_art ['.#.....#.',
'####.####',
'#.....#..',
'#####.##.',
'##.######',
'##.#..#..',
'.##.#.##.',
'#########',
'...#..#..']
    puts "grid from test: #{grid}"
    assert_equal('.#./###/#..', grid[0][0])
  end

  def test_three_is_not_four
    assert_false(is_four([['.#./..#/###']]))
  end

  def test_two_is_not_four
    assert_false(is_four([['.#/..']]))
  end

  def test_four_is_four
    assert_true(is_four([['#..#/..../..../#..#']]))
  end

  def test_rotate
    rotated = rotate '.#./..#/###'
    assert_equal('#../#.#/##.', rotated)
  end

  def test_flip_vertical
    flipped = flip_vertical '.#./..#/###'
    assert_equal('.#./#../###', flipped)
  end

  def test_another_flip_vertical
    flipped = flip_vertical '.##/#.#/#..'
    assert_equal('##./#.#/..#', flipped)
  end

  def test_flip_horizontal
    flipped = flip_horizontal '.#./..#/###'
    assert_equal('###/..#/.#.', flipped)
  end

  def test_another_flip_horizontal
    flipped = flip_horizontal '.##/#.#/#..'
    assert_equal('#../#.#/.##', flipped)
  end

  def test_count_art
    count = count_art flatten([['.#./..#/###','.#./..#/###'],['.#./..#/###','.#./..#/###']])
    assert_equal(20, count)
  end

  def test_count_another_art
    count = count_art flatten([[".##/###/...", "##./###/#.."], [".../#.#/...", "###/##./##."]])
    assert_equal(20, count)
  end

  def test_count_a_longer_art
    count = count_art flatten([[".#/#.", "##/##", "../##", "#./.#"], ["##/.#", "../#.", "##/##", "##/.."], ["../##", ".#/..", ".#/##", ".#/##"], [".#/..", "#./..", "#./##", "##/.."]])
    assert_equal(36, count)
  end

  def test_from_q
    count = count_art(iterate 2, TEST_INPUT)
    assert_equal(12, count)
  end

  def test_part_1
    count = count_art(iterate 5, REAL_INPUT)
    assert_equal(184, count)
  end

  def test_part_2
    count = count_art(iterate 18, REAL_INPUT)
    puts "answer: #{count}"
  end

end