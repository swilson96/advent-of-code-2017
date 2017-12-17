require_relative "./day10"

class Layer

end

class Day14
  def initialize(input)
    @input = input
  end

  def count
    (0..127).map{ |row| knot_hash 256, "#{@input}-#{row}" }
      .map{ |hash| hash.split(//).map {|char| char.hex.to_s(2) }.inject(0){|count,x| count + x.count("1")} }
      .inject(0){|sum,x| sum + x}
  end

  def count_regions
    0
  end
end

