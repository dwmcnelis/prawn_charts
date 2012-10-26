
require 'prawn_charts/layouts/layout'

module PrawnCharts
  module Layouts

    # Provides a more appropriate layout for Pie Charts.
    class Pie < Layout

      def initialize
        self.components = []
        self.components << PrawnCharts::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])
        self.components << PrawnCharts::Components::Graphs.new(:graphs, :position => [0, 11], :size => [70, 85])
        self.components << PrawnCharts::Components::Title.new(:title, :position => [5, 2], :size => [90, 7])
        self.components << PrawnCharts::Components::Legend.new(:legend, :position => [70, 11], :size => [30, 85], :vertical_legend => true)
      end
    end # Pie

  end # Layouts
end # PrawnCharts