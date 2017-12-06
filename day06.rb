$testInput = "0 2 7 0"
$realInput = "5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6"

# First half

def printMemory(step, memory, index, to_allocate)
  puts "#{step}: #{memory.join(" ")} index: #{index}, to allocate: #{to_allocate}"
end

def solve1(input)
  step = 0
  memory = input.split.map { |a| a.to_i }
  witnessed = []

  while !witnessed.include?(memory)
    witnessed << memory.dup

    index = memory.index(memory.max)
    to_allocate = memory.max

    printMemory step, memory, index, to_allocate

    memory[index] = 0
    (1..to_allocate).each do |i|
      memory[(index + i) % memory.length] += 1
    end

    step += 1
  end

  printMemory step, memory, -1, 0

  puts step - witnessed.index(memory)

  step
end

puts solve1($testInput)

puts solve1($realInput)
