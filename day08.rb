$testInput = "b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"

$realInput = File.open("day08.txt").read

class Instruction
  def initialize(input)
    words = input.split
    @key = words[0]
    @action = words[1]
    @amount = words[2].to_i
    @condition_key = words[4]
    @condition_op = words[5]
    @condition_bench = words[6].to_i
  end

  def apply(registers)
    # puts "reg: #{registers}"
    # puts self.to_s

    registers[@key] = 0 unless registers.include?(@key)
    registers[@condition_key] = 0 unless registers.include?(@condition_key)

    # puts "test? #{test?(registers)}"

    act(registers) if test?(registers)
  end

  def test?(registers)
    return registers[@condition_key] > @condition_bench if @condition_op == ">"
    return registers[@condition_key] < @condition_bench if @condition_op == "<"
    return registers[@condition_key] == @condition_bench if @condition_op == "=="
    return registers[@condition_key] != @condition_bench if @condition_op == "!="
    return registers[@condition_key] >= @condition_bench if @condition_op == ">="
    return registers[@condition_key] <= @condition_bench if @condition_op == "<="
  end

  def act(registers)
    registers[@key] += @amount if @action == "inc"
    registers[@key] -= @amount if @action == "dec"
  end

  def to_s
    "#{@key} #{@action} #{@amount} if #{@condition_key} #{@condition_op} #{@condition_bench}"
  end
end

def process(input)
  registers = Hash.new

  current_max = 0

  instructions = input.lines.map { |l| Instruction.new(l) }

  instructions.each {|instruction|
    instruction.apply(registers)
    current_max = [current_max, registers.values.max].max
  }

  puts "largest at end: #{registers.values.max}, largest ever: #{current_max}"
end

puts process($testInput)
puts process($realInput)
