def find_from_starting initial_bridge, port, remaining
  # puts "searching! #{initial_bridge}, #{remaining}"
  [initial_bridge] + remaining.select{|piece| piece.include?(port)}
                              .flat_map{|piece| (piece[0] == port ? find_from_starting(initial_bridge + [piece], piece[1], remaining - [piece]) : []) +
                                                (piece[1] == port ? find_from_starting(initial_bridge + [piece], piece[0], remaining - [piece]) : []) }
end

def parse_input(input)
  input.lines.map{|l| l.chomp.split('/').map{|port| port.to_i}}
end

def strongest input
  pieces = parse_input(input)

  # pieces = pieces + pieces.map{|piece| piece.reverse}

  bridges = find_from_starting [], 0, pieces

  puts "#{bridges.size} bridges found"
  # bridges.each do |bridge|
  #   puts "#{bridge}"
  # end

  bridges.map{|b| b.inject(0){|sum, piece| sum + piece[0] + piece[1]}}.max
end

def longest input
  pieces = parse_input(input)

  bridges = find_from_starting [], 0, pieces

  puts "#{bridges.size} bridges found"

  longest_length = bridges.map{|bridge| bridge.length}.max

  puts "longest bridge: #{longest_length}"

  long_bridges = bridges.select{|bridge| bridge.length == longest_length}

  long_bridges.map{|b| b.inject(0){|sum, piece| sum + piece[0] + piece[1]}}.max
end
