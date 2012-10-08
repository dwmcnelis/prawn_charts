module PrawnCharts::Renderers
  # The Basic Renderer Creates a Blank Graph with everything ready for adding components
  class Basic < Base

    def define_layout
      components << PrawnCharts::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])
      components << PrawnCharts::Components::Viewport.new(:view, :position => [2, 26], :size => [89, 66]) do |graph|
          graph << PrawnCharts::Components::Graphs.new(:graphs, :position => [3, 0], :size => [80, 89])
          graph << PrawnCharts::Components::ValueMarkers.new(:values, :position => [0, 0], :size => [1, 89])
          graph << PrawnCharts::Components::Axis.new(:values, :position => [3, 0], :size => [80, 89])
      end
      yield(self.components) if block_given?
    end
  end
end