
require 'prawn_charts/layouts/layout'

module PrawnCharts
  module Layouts

    # Experimental, do not use.
    class Sparkline < Layout
      def define_layout
        self.components << PrawnCharts::Components::Graphs.new(:sparkline, :position => [0, 0], :size => [100, 100])
      end
    end # SparkLine

  end # Layouts
end # PrawnCharts