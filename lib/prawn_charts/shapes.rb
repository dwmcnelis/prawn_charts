
require "prawn_charts/shapes/arc"
require "prawn_charts/shapes/axis"
require "prawn_charts/shapes/star"

module PrawnCharts

  # Implements shape drawing for Prawn::Document.
  module Shapes
    include Arc
    include Axis
    include Star
  end # Shapes

end # PrawnCharts

