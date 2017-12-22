START = ['.#.','..#','###']

def split_4_into_2s(four)
  rows = four.split '/'
  [["#{rows[0][0..1]}/#{rows[1][0..1]}","#{rows[0][2..3]}/#{rows[1][2..3]}"],
   ["#{rows[2][0..1]}/#{rows[3][0..1]}","#{rows[2][2..3]}/#{rows[3][2..3]}"]]
end

def row_to_two_rows(row)
  row_of_fours = row.map{|piece| split_4_into_2s piece}

  [row_of_fours.flat_map{|pieces| pieces[0] },
   row_of_fours.flat_map{|pieces| pieces[1] }]
end

def split_fours(art)
  art.flat_map{|row| row_to_two_rows(row) }
end

def map_from_input(input)
  input.lines.map{|l| l.chomp.split(/ /)}.map{|words| [words[0],words[2]]}.to_h
end

def rotate(input)
  rows = input.split '/'
  size = rows.size
  (0..(size-1)).to_a.map{|i| (1..size).to_a.map{|j| size-j}.map{|j| rows[j][i]}.join }.join('/')
end

def flip_vertical(input)
  input.split('/').map{|s| s.reverse}.join('/')
  # rotate(rotate(flip_horizontal(input)))
end

def flip_horizontal(input)
  input.split('/').reverse.join('/')
end

def find_match(input, map)
  return map[input] if map.has_key?(input)

  rotate_once = rotate(input)
  return map[rotate_once] if map.has_key?(rotate_once)

  # i think flipping should be more than twice as fast as rotating?
  rotate_twice = flip_horizontal(flip_vertical(input))
  return map[rotate_twice] if map.has_key?(rotate_twice)

  rotate_thrice = flip_horizontal(flip_vertical(rotate_once))
  return map[rotate_thrice] if map.has_key?(rotate_thrice)

  flipped = flip_horizontal(input)
  return map[flipped] if map.has_key?(flipped)

  f_rotate_once = flip_horizontal(rotate_once)
  return map[f_rotate_once] if map.has_key?(f_rotate_once)

  f_rotate_twice = flip_horizontal(rotate_twice)
  return map[f_rotate_twice] if map.has_key?(f_rotate_twice)

  f_rotate_thrice = flip_horizontal(rotate_thrice)
  return map[f_rotate_thrice] if map.has_key?(f_rotate_thrice)

  throw "NO MATCH IN BOOK FOR #{input}"
end

def is_four(art)
  art[0][0].index('/') == 4
end

def grid_art(art)
  size = art.size

  if size % 2 == 0
    (0..(size - 2)).step(2).to_a
        .map{|i| (0..(size - 2)).step(2).to_a
                     .map{ |j| "#{art[i][j..j+1]}/#{art[i+1][j..j+1]}" } }
  else
    (0..(size - 3)).step(3).to_a
        .map{|i| (0..(size - 3)).step(3).to_a
                     .map{ |j| "#{art[i][j..j+2]}/#{art[i+1][j..j+2]}/#{art[i+2][j..j+2]}" } }
  end
end

def flatten(grid)
  grid.flat_map{|row| (0..(row[0].index('/')-1)).to_a.map{|i| row.map{|piece| piece.split('/')[i]}.join } }
end

def enhance(art, map)

  gridded_art = grid_art(art)

  new_grid = gridded_art.map{|row| row.map{|piece| find_match(piece, map)}}

  new_art = flatten(new_grid)

  new_art
end

def iterate(times, input)
  art = START
  map = map_from_input(input)

  puts 'new art'

  (1..times).each do |i|
    puts "iteration #{i}..."
    art = enhance(art, map)
  end

  art
end

def count_art art
  art.inject(0){|acc, row| acc + row.count('#') }
end