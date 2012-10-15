
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Grid < Component
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        markers = (options[:markers] || self.markers) || 5

        stroke_width = options[:stroke_width]

        colour = options[:theme].grid || options[:theme].marker

        each_marker(markers, options[:min_value], options[:max_value], bounds[:height], options, :value_formatter) do |label, y|
          pdf.line(:x1 => 0, :y1 => y, :x2 => bounds[:width], :y2 => y, :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
        end

        #add a 0 line
        y = (options[:max_value] * bounds[:height])/(options[:max_value] - options[:min_value])
        pdf.line(:x1 => 0, :y1 => y, :x2 => bounds[:width], :y2 => y, :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")

      end
    end # Grid

  end # Components
end # PrawnCharts

