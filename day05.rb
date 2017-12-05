$testInput = "0
3
0
1
-3"


# First half

def printInstructions(instructions, index)
  puts "#{instructions.join(" ")} index: #{index}"
end


def solve1(input)
  index = 0
  step = 0
  instructions = input.lines.map { |a| a.to_i }

  while index >= 0 && index < instructions.length
    # printInstructions instructions, index
    jump = instructions[index]
    instructions[index] += 1
    index += jump
    step += 1
  end

  step
end

puts solve1($testInput)

$realInput = File.open("day05.txt").read

puts solve1($realInput)


# second half

def solve2(input)
  index = 0
  step = 0
  instructions = input.lines.map { |a| a.to_i }

  while index >= 0 && index < instructions.length
    # printInstructions instructions, index
    jump = instructions[index]

    instructions[index] += 1 unless jump >= 3
    instructions[index] -= 1 unless jump < 3

    index += jump
    step += 1
  end

  step
end

puts "part 2"
puts solve2($testInput)
puts solve2($realInput)