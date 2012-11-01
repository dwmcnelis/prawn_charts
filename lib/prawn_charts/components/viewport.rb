
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    # Component used to limit other visual components to a certain area on the graph.
    class Viewport < Component
      include PrawnCharts::Helpers::Canvas

      def initialize(*args, &block)
        super(*args)

        self.components = []
        block.call(self.components) if block
      end

      def draw(pdf, bounds, options={})
          self.components.each do |component|
            sub_bounds = bounds_for([bounds[:width], bounds[:height]],
                                    component.position,
                                    component.size)
            pdf.bounding_box([bounds[:x]+sub_bounds[:x],bounds[:y]+bounds[:height]-sub_bounds[:y]], :width => sub_bounds[:width], :height => sub_bounds[:height]) do
              component.render(pdf,
                bounds_for([bounds[:width], bounds[:height]],
                  [0.0,0.0],
                  component.size),
                options)
            end
          end
      end

    end # Viewport

  end # Components
end # PrawnCharts
