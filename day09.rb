def strip_bangs stream
  bangless = ""
  ignore = false
  stream.split('').each do |char|
    if ignore
      ignore = false
    else
      bangless += char unless char == '!'
      ignore = char == '!'
    end
  end
  bangless
end

def take_out_the_trash stream
  squeaky_clean = ""
  garbage = false
  stream.split('').each do |char|
    if garbage
      garbage = false if char == '>'
    else
      squeaky_clean += char unless char == '<'
      garbage = char == '<'
    end
  end
  squeaky_clean
end

def score stream

  stream = take_out_the_trash strip_bangs stream

  total = 0
  depth = 1
  stream.split('').each do |char|
    total += depth if char == '{'
    depth += 1 if char == '{'
    depth -= 1 if char == '}'
  end

  total
end

def test stream, expected
  result = score(stream)
  # puts "#{stream} PASS!" if result == expected
  puts "#{stream} FAIL!!! expected #{expected} got #{result}" if result != expected
end

test "{}", 1
test "{{{}}}", 6
test "{{},{}}", 5
test "{{{},{},{{}}}}", 16
test "{<a>,<a>,<a>,<a>}", 1
test "{{<ab>},{<ab>},{<ab>},{<ab>}}", 9
test "{{<!!>},{<!!>},{<!!>},{<!!>}}", 9
test "{{<a!>},{<a!>},{<a!>},{<ab>}}", 3

$realInput = File.open("inputs/day09.txt").read

puts score $realInput

def rummage_in_the_trash stream
  garbage = false
  haul = 0
  stream.split('').each do |char|
    if garbage
      haul += 1 if char != '>'
      garbage = false if char == '>'
    else
      garbage = char == '<'
    end
  end
  haul
end

puts rummage_in_the_trash strip_bangs $realInput
