
require 'prawn_charts/renderers/renderer'

module PrawnCharts
  module Renderers

    # Experimental, do not use.
    class Sparkline < Renderer
      def define_layout
        self.components << PrawnCharts::Components::Graphs.new(:sparkline, :position => [0, 0], :size => [100, 100])
      end
    end # SparkLine

  end # Renderers
end # PrawnCharts