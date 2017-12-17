def one_hash_round size, lengths_string
  lengths = lengths_string.split(',').map {|a| a.to_i}
  list = (0..(size-1)).to_a
  #puts list.join(", ")

  pos = 0
  skip = 0
  lengths.each do |length|
    reverse = (0..(length-1)).map { |i| list[(pos + i) % size] }.reverse
    #puts "reversed this bit (start #{pos}, length #{length}): #{reverse.join(", ")}"
    (0..(length-1)).each do |i|
      list[(pos + i) % size] = reverse[i]
    end
    #puts list.join(", ")
    pos = (pos + length + skip) % size
    skip += 1
  end
  list[0] * list[1]
end

def test size, lengths, expected
  result = one_hash_round size, lengths
  # puts "#{stream} PASS!" if result == expected
  puts "#{size} : #{lengths} FAIL!!! expected #{expected} got #{result}" if result != expected
end

test 5, "3,4,1,5", 12

$realInput = "165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153"

puts one_hash_round 256, $realInput

def to_hex_string a
  hex = a.to_s(16)
  hex = "0" + hex if hex.length < 2
  hex
end

def knot_hash size, lengths_string
  lengths = lengths_string.split(//).map {|a| a.ord}
  [17, 31, 73, 47, 23].each { |extra| lengths.push extra }

  list = (0..(size-1)).to_a
  pos = 0
  skip = 0

  (1..64).each do
    lengths.each do |length|
      reverse = (0..(length-1)).map { |i| list[(pos + i) % size] }.reverse
      #puts "reversed this bit (start #{pos}, length #{length}): #{reverse.join(", ")}"
      (0..(length-1)).each do |i|
        list[(pos + i) % size] = reverse[i]
      end
      #puts list.join(", ")
      pos = (pos + length + skip) % size
      skip += 1
    end
  end

  dense = list.each_slice(16).map {|chunk| chunk.inject(0){|acc,x| acc ^ x }}

  hex = dense.inject(""){|acc,x| acc + to_hex_string(x) }

  hex
end

puts knot_hash 256, $realInput