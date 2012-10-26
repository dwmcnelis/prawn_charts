
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
            component.render(pdf,
              bounds_for([bounds[:width], bounds[:height]],
                component.position,
                component.size),
              options)
          end
      end

    end # Viewport

  end # Components
end # PrawnCharts
