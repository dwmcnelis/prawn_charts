
class Numeric
  # numeric in degrees converted to radians
  def radians
    self * Math::PI / 180.0
  end

  # numeric in radians converted to degrees
  def degrees
    self * 180.0 / Math::PI
  end
end
