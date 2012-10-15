
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    # Common attributes for all components, and a standard render method
    # that calls draw after setting up the drawing transformations.
    class Component
      attr_reader :id

      # In terms of percentages:  [10, 10] == 10% by 10%
      attr_accessor :position
      attr_accessor :size
      attr_accessor :options
      attr_accessor :visible

      # Options:
      # stroke_width:: numeric value for width of line (0.1 - 10, default: 1)
      def initialize(id, options = {})
        @id = id.to_sym
        @position = options[:position] || [0, 0]
        @size = options[:size] || [100, 100]
        @visible = options[:visible] || true

        @options = options
      end

      def render(pdf, bounds, options={})
        if @visible
          unless bounds.nil?
            @render_height = bounds[:height]

            #pdf.g(:id => id.to_s,
            #      :transform => "translate(#{bounds.delete(:x)}, #{bounds.delete(:y)})") {

            draw(pdf, bounds, options.merge(@options))
            #}
          else
            process(pdf, options.merge(@options))
          end
        end
      end

      def draw(pdf, bounds, options={})
        # Override this for visual component
      end

      def process(pdf, options={})
        # Override this for non-visual component
      end

      protected
      def relative(pct)
        @render_height * ( pct / 100.to_f )
      end
    end # Component

  end # Components
end # PrawnCharts
