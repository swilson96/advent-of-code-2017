require_relative "./day10"

class Layer

end

class Day14
  def initialize(input)
    @rows = (0..127).map{ |row| knot_hash 256, "#{@input}-#{row}" }
                .map{ |hash|
                  hash.split(//)
                      .map {|char| char.hex.to_s(2).rjust(4, "0") }
                      .inject(""){|acc,x| acc + x }
                      .split(//)
                      .map {|c| c.to_i }
                      .map {|i| -i }
                }
    @next_colour = 1
  end

  def count
    # (0..127).map{ |row| knot_hash 256, "#{@input}-#{row}" }
    #   .map{ |hash| hash.split(//).map {|char| char.hex.to_s(2) }.inject(0){|count,x| count + x.count("1") } }
    #   .inject(0){|sum,x| sum + x }

    -@rows.map{|row| row.inject(0){|sum,x| sum + x } }
         .inject(0){|sum,x| sum + x }
  end

  def count_regions
    (0..127).each do |row_index|
      (0..127).each do |col_index|
        colour_group row_index, col_index if @rows[row_index][col_index] < 0
      end
    end

    @next_colour - 1
  end

  def colour_group x, y
    col_next x, y
    @next_colour += 1
  end

  def col_next x, y
    @rows[x][y] = @next_colour
    col_next x-1, y if x > 0 && @rows[x-1][y] < 0
    col_next x, y-1 if y > 0 && @rows[x][y-1] < 0
    col_next x+1, y if x < 127 && @rows[x+1][y] < 0
    col_next x, y+1 if y < 127 && @rows[x][y+1] < 0
  end
end

