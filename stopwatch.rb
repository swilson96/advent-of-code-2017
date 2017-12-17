class Stopwatch

  def initialize()
    @start = Time.now
  end

  def seconds
    now = Time.now
    elapsed = now - @start
    elapsed.to_s
  end

end