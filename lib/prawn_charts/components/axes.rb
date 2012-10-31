
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Axes < Component
      include PrawnCharts::Helpers::Marker

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        stroke_width = options[:stroke_width]

        color = theme.grid || theme.marker
        unless options[:show_x] == false
          y = (options[:max_value] * bounds[:height])/(options[:max_value] - options[:min_value])
          pdf.text_mark "line stroke_line [0, #{y}], [#{bounds[:width]}, #{y}]"
          pdf.stroke_color = color
          pdf.stroke_line [0, y], [bounds[:width], y]
          #pdf.line(:x1 => 0, :y1 => y, :x2 => bounds[:width], :y2 => y, :style => "stroke: #{color.to_s}; stroke-width: #{stroke_width};")
        end

        unless options[:show_y] == false
          x = -0.5
          pdf.text_mark "line stroke_line [#{x}, #{0}], [#{x}, #{bounds[:height]}]"
          pdf.stroke_color = color
          pdf.stroke_line [x, 0], [x, bounds[:height]]
        #pdf.line(:x1 => x, :y1 => 0, :x2 => x, :y2 => bounds[:height], :style => "stroke: #{color.to_s}; stroke-width: #{stroke_width};")
        end
      end
    end # Axes

  end # Components
end # PrawnCharts

