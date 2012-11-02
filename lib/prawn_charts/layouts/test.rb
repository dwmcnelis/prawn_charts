
require 'prawn_charts/layouts/empty'

module PrawnCharts
  module Layouts

    class Test < Empty
      def define_layout
        super do |components|
          self.components << PrawnCharts::Components::Title.new(:title, :position => [5, 93], :size => [90, 7])
          components << PrawnCharts::Components::Viewport.new(:view, :position => [5, 10], :size => [90, 80]) do |graph|
            graph << PrawnCharts::Components::ValueMarkers.new(:values, :position => [5, 5], :size => [10, 90])
            graph << PrawnCharts::Components::Grid.new(:grid, :position => [5, 5], :size => [90, 90], :stroke_width => 1)
            graph << PrawnCharts::Components::VerticalGrid.new(:vgrid, :position => [5, 5], :size => [90, 90], :stroke_width => 1, :key_markers => 20)
            graph << PrawnCharts::Components::DataMarkers.new(:labels, :position => [10, 92], :size => [90, 8])
            graph << PrawnCharts::Components::Graphs.new(:graphs, :position => [5, 5], :size => [90, 90])
          end
          components << PrawnCharts::Components::Legend.new(:legend, :position => [5, 5], :size => [90, 5])
        end
      end

      protected
      def hide_values
        super
        component(:view).position[0] = -10
        component(:view).size[0] = 100
      end

      def labels
        [component(:view).component(:labels)]
      end

      def values
        [component(:view).component(:values)]
      end

      def grids
        [component(:view).component(:grid),component(:view).component(:vertical_grid)]
      end
    end # Default

  end # Layouts
end # PrawnCharts