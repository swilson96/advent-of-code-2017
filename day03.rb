$input = 289326

puts $input

# First half

$total = 1

puts "Level 1: 1 to 1, 0 per side"

$level = 2

while $total < $input do
  start = $total + 1
  side = 2 * ($level-1)
  finish = start + (4 * side) - 1
  #puts "Level #{$level}: #{start} to #{finish}, #{side} per side"

  $total = finish
  $level += 1
end

puts $total

puts "Level 270: 288370 to 290521, 538 per side"

puts "Corners:"
puts "#{288370} is at (269, -#{536/2})"
topRightCorner = 288370 + 538 - 1
puts "#{topRightCorner} is at (269, #{538/2})"
puts "#{$input} is #{$input - topRightCorner} further down the edge"
puts "#{$input} is at (#{(538/2) - $input + topRightCorner}, 269)"

puts "#{288370 + 538 + 538 - 1} is at (#{269 - 538}, #{538/2})"
puts "#{288370 + 538 + 538 + 583 - 1} is at (#{269 - 538}, -#{538/2})"
puts "#{288370 + 538 + 538 + 538 + 538 - 1} is at (#{269}, -#{538/2})"

puts "distance: #{269 + 150}"

# second half

def corner(x, y)
  # 1 x 0
  # x   x
  # 2 x 3
  return -1 unless x == y || x == -y
  return 0 if x > 0 and y > 0
  return 1 if x < 0 and y > 0
  return 2 if x < 0 and y < 0
  return 3 if x > 0 and y < 0
end

def corner_from_point(point)
  corner(point[0], point[1])
end

def side(x,y)
  # x 1 x
  # 2   0
  # x 3 x
return 0 if x > y && x > -y
return 1 if x < y && x > -y
return 2 if x < y && x < -y
return 3 if x > y && x < -y
end

puts "corners test"
puts corner(1,1)
puts corner(-1,1)
puts corner(-1,-1)
puts corner(1,-1)

puts "side test"
puts side(1,0)
puts side(0,1)
puts side(-1,0)
puts side(0,-1)

def left(x,y)
  [x-1, y]
end

def right(x,y)
  [x+1, y]
end

def up(x,y)
  [x, y+1]
end

def down(x,y)
  [x, y-1]
end

def down_left(x,y)
  [x-1, y-1]
end

def down_right(x,y)
  [x+1, y-1]
end

def up_left(x,y)
  [x-1, y+1]
end

def up_right(x,y)
  [x+1, y+1]
end

def start_of_layer?(x, y)
  corner_from_point(down(x,y)) == 3
end

def just_before_corner?(x, y)
  corner_from_point(down(x,y)) == 2 || corner_from_point(right(x,y)) == 3 || corner_from_point(up(x,y)) == 0 || corner_from_point(left(x,y)) == 1
end

puts "just before corner?"
puts just_before_corner?(2, 1)

$grid = Hash.new

$grid[[0,0]] = 1
$grid[[1,0]] = 1

def score_inner(point)
  x = point[0]
  y = point[1]

  debug = x == -1 && y == -2

  return score(left(x,y)) + score(up_left(x, y)) if start_of_layer?(x, y)

  corner = corner(x,y)
  return score(down(x,y)) + score(down_left(x,y)) if corner == 0
  return score(right(x,y)) + score(down_right(x,y)) if corner == 1
  return score(up(x,y)) + score(up_right(x,y))if corner == 2
  # corner 3 is the last element of the last layer
  return score(up(x,y)) + score(left(x,y)) + score(up_left(x,y)) if corner == 3

  side = side(x,y)
  puts "(#{x},#{y}) side: #{side}, corner: #{corner} pre-corner: #{just_before_corner?(x,y)}" if debug
  return score(left(x,y)) + score(down(x,y)) + score(down_left(x,y)) + (!just_before_corner?(x,y) ? score(up_left(x,y)) : 0) if side == 0
  return score(down(x,y)) + score(right(x,y)) + score(down_right(x,y)) + (!just_before_corner?(x,y) ? score(down_left(x,y)) : 0) if side == 1
  return score(right(x,y)) + score(up(x,y)) + score(up_right(x,y)) + (!just_before_corner?(x,y) ? score(down_right(x,y)) : 0) if side == 2
  return score(up(x,y)) + score(left(x,y)) + score(up_left(x,y)) + score(up_right(x,y)) if side == 3
end

def score(point)
  return $grid[point] if $grid.include?(point)

  value = score_inner(point)

  $grid[point] = value

  value
end


def write_score(x, y)
  puts "(#{x},#{y}): #{score([x,y])}"
end

write_score(0,0)
write_score(1,0)
write_score(1,1)
write_score(0,1)
write_score(-1,1)
write_score(-1,0)
write_score(-1,-1)
write_score(0,-1)
write_score(1,-1)
write_score(2,-1)
write_score(2,0)
write_score(2,1)
write_score(2,2)
write_score(1,2)
write_score(0,2)
write_score(-1,2)
write_score(-2,2)
write_score(-2,1)
write_score(-2,0)
write_score(-2,-1)
write_score(-2,-2)
write_score(-1,-2)
write_score(0,-2)

$val = 0
$layer = 2
while $val < $input
  $layer +=1
  $val = score([-$layer,$layer])
  puts "layer: #{$layer}, value: #{$val}"
end

$back_track = 0

while $val > $input
  $back_track += 1
  $val = score([$back_track - $layer,$layer])
  puts "(#{$back_track - $layer},#{$layer}): value: #{$val}"
end


