class Vector
  attr_accessor :x, :y, :z

  def initialize(array)
    @x = array[0].to_i
    @y = array[1].to_i
    @z = array[2].to_i
  end

  def manhattan_distance
    @x.abs + @y.abs + @z.abs
  end

  def ==(other)
    other.x == @x && other.y == @y && other.z == @z
  end

  def to_s
    "<#{@x},#{@y},#{@z}>"
  end
end

class Particle
  attr_accessor :p, :leaving, :name

  def initialize(name, input)
    @name = name
    vector_string_hash = input.chomp.split(/, /).map{|s| [s[0], s.strip[3..-2].strip.split(',')]}.to_h
    @a = Vector.new vector_string_hash['a']
    @v = Vector.new vector_string_hash['v']
    @p = Vector.new vector_string_hash['p']
    @leaving = false
  end

  def tick
    old = @p

    @v.x += @a.x
    @v.y += @a.y
    @v.z += @a.z
    @p.x += @v.x
    @p.y += @v.y
    @p.z += @v.z

    @leaving = old.manhattan_distance < @p.manhattan_distance
  end

  def acceleration
    @a.manhattan_distance
  end

  def distance
    @p.manhattan_distance
  end

  def to_s
    "p=#{@p}, v=#{@v}, a=#{@a}"
  end
end

class System
  def initialize input
    @particles = input.lines.each_with_index.map{|s,i| Particle.new(i,s)}
  end

  def tick
    @particles.each do |p|
      p.tick
    end
  end

  def remove_collisions
    seen = []
    collision_points = []
    @particles.each do |particle|
      if seen.include? particle.p
        # puts "COLLISION DETECTED AT #{particle.p}!!!"
        collision_points << particle.p
      end
      seen << particle.p
    end

    @particles.select!{|p| !collision_points.include?(p.p)}
  end

  def all_leaving
    !@particles.select{|p| !p.leaving}.any?
  end

  def remaining
    @particles.size
  end

  def slowest
    lowest_index = 0
    lowest = 2^30
    @particles.each do |p|
      if p.acceleration < lowest
        lowest = p.acceleration
        lowest_index = p.name
      end
    end
    lowest_index
  end

  def stable
    @particles
  end
end