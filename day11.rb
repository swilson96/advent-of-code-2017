def mod x, y
  return (x.abs + y.abs) if (x >= 0 && y <= 0) || (x <= 0 && y >= 0)

  [x.abs, y.abs].max
end

def test_mod x, y, expected
  result = mod x, y
  puts "(#{x}, #{y}) FAIL!!! expected #{expected} got #{result}" if result != expected
end

test_mod 0, 0, 0
test_mod 2, 0, 2
test_mod 0, -1, 1
test_mod 3, 3, 3
test_mod 3, -3, 6


def shorten input
  x = 0
  y = 0

  furthest = 0

  input.split(',').each do |step|
    x += 1 if step == 'se'
    x -= 1 if step == 'nw'
    y += 1 if step == 'n'
    y -= 1 if step == 's'
    if step == 'ne'
      x += 1
      y += 1
    end
    if step == 'sw'
      x -= 1
      y -= 1
    end

    furthest = [furthest, (mod x, y)].max
  end

  # mod x, y
  furthest
end

def test input, expected
  result = shorten input
  # puts "#{input} PASS!" if result == expected
  puts "[#{input}] FAIL!!! expected #{expected} got #{result}" if result != expected
end

test "ne,ne,ne", 3
test "ne,ne,sw,sw", 0
test "ne,ne,s,s", 2
test "se,sw,se,sw,sw", 3

$realInput = File.open("inputs/day11.txt").read

puts shorten $realInput

