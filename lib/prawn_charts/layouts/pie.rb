
require 'prawn_charts/layouts/layout'

module PrawnCharts
  module Layouts

    # Provides a more appropriate layout for Pie Charts.
    class Pie < Layout
      def define_layout
        self.components = []
        #self.components << PrawnCharts::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])
        self.components << PrawnCharts::Components::Title.new(:title, :position => [0, 93], :size => [100, 7])
        #components << PrawnCharts::Components::Viewport.new(:view, :position => [0, 20], :size => [89, 66]) do |graph|
        self.components << PrawnCharts::Components::Graphs.new(:graphs, :position => [0, 0], :size => [63, 93])
        #self.components << PrawnCharts::Components::Axes.new(:values, :position => [5, 0], :size => [60, 85])
        #self.components << PrawnCharts::Components::Grid.new(:values, :position => [5, 0], :size => [60, 85])
        #graph << PrawnCharts::Components::ValueMarkers.new(:values, :position => [0, 0], :size => [1, 89])
        #graph << PrawnCharts::Components::Grid.new(:grid, :position => [10, 0], :size => [90, 89], :stroke_width => 1)
        #graph << PrawnCharts::Components::VerticalGrid.new(:vertical_grid, :position => [10, 0], :size => [90, 89], :stroke_width => 1)
        #graph << PrawnCharts::Components::Axis.new(:values, :position => [3, 0], :size => [80, 89])
        #graph << PrawnCharts::Components::DataMarkers.new(:labels, :position => [10, 92], :size => [90, 8])
        #end
        self.components << PrawnCharts::Components::Legend.new(:legend, :position => [65, 15], :size => [35, 65], :vertical_legend => true)
      end
    end # Pie
  end # Layouts
end # PrawnCharts