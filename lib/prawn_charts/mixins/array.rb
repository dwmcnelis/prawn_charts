
class Array
  def unit_vector
    denominator = Math.sqrt(self[0] * self[0] + self[1] * self[1])
    return self if denominator == 0.0
    [self[0] / denominator, self[1] / denominator]
  end

  # if :counter_clockwise => true option, then return a new vector
  # that points 90 degrees counterlockwise of aVector with a magnitude
  # of 1.0, otherwise return a new vector that points 90 degrees
  # clockwise of aVector with a magnitude of 1.0
  def unit_perpendicular_vector(options={})
    return [self[1], -self[0]].unit_vector if options[:counter_clockwise]
    [-self[1], self[0]].unit_vector
  end
end
