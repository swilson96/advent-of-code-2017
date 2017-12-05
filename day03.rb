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


