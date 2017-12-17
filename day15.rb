class Day15
  FactorA = 16807
  FactorB = 48271
  Ceiling = 2147483647 # MAX_INT
  Judge_ceiling = 65536 # 2^16

  def initialize(seedA, seedB)
    @a = seedA
    @b = seedB
  end

  def generate
    @a = (@a * FactorA) % Ceiling
    @b = (@b * FactorB) % Ceiling
  end

  def a
    @a
  end

  def b
    @b
  end

  def judge
    return @a % Judge_ceiling == @b % Judge_ceiling
  end

  def solve
    count = 0
    (1..40000000).each do
      generate
      count += 1 if judge
    end
    count
  end
end

class Day15_part2
  FactorA = 16807
  FactorB = 48271
  Ceiling = 2147483647 # MAX_INT
  Judge_ceiling = 65536 # 2^16

  def initialize(seedA, seedB)
    @a = seedA
    @b = seedB
  end

  def generate
    @a = (@a * FactorA) % Ceiling
    while @a % 4 != 0
      @a = (@a * FactorA) % Ceiling
    end

    @b = (@b * FactorB) % Ceiling
    while @b % 8 != 0
      @b = (@b * FactorB) % Ceiling
    end
  end

  def a
    @a
  end

  def b
    @b
  end

  def judge
    return @a % Judge_ceiling == @b % Judge_ceiling
  end

  def solve
    count = 0
    (1..5000000).each do
      generate
      count += 1 if judge
    end
    count
  end
end

