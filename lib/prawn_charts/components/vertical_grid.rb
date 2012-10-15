
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class VerticalGrid < Component
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        colour = options[:theme].grid || options[:theme].marker

        if options[:graph].point_markers #get vertical grid lines up with points if there are labels for them
          point_distance = bounds[:width] / (options[:graph].point_markers.size).to_f
          stroke_width = options[:stroke_width]
          (0...options[:graph].point_markers.size).map do |idx|
            x = point_distance * idx  + point_distance/2
            pdf.line(:x1 => x, :y1 => 0, :x2 => x, :y2 => bounds[:height], :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
          end
          #add the far right and far left lines
          pdf.line(:x1 => 0, :y1 => 0, :x2 => 0, :y2 => bounds[:height], :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
          pdf.line(:x1 => bounds[:width], :y1 => 0, :x2 => bounds[:width], :y2 => bounds[:height], :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
        else

          markers =  (options[:key_markers] || self.markers) || 5 #options[:point_markers].size#
          stroke_width = options[:stroke_width]
          each_marker(markers, options[:min_key], options[:max_key], bounds[:width], options, :key_formatter) do |label, x|
            pdf.line(:x1 => x, :y1 => 0, :x2 => x, :y2 => bounds[:height], :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
          end

        end
      end
    end # Vertical Grid

  end # Components
end # PrawnCharts

