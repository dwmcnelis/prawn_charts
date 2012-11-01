
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Axes < Component
      include PrawnCharts::Helpers::Marker

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        #pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        #pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        save_line_width = pdf.line_width
        stroke_width = (options[:relative]) ? relative(options[:stroke_width]) : options[:stroke_width]
        color = theme.grid || theme.marker || '000000'
        unless options[:show_x] == false
          y = (options[:max_value] * bounds[:height])/(options[:max_value] - options[:min_value])
          #pdf.text_mark "y #{y}"
          pdf.stroke_color = color
          pdf.line_width = stroke_width
          #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]}, #{pdf.bounds.bottom+bounds[:y]+y}], [#{pdf.bounds.left+bounds[:x]+bounds[:width]}, #{pdf.bounds.bottom+bounds[:y]+y}]"
          pdf.stroke_line [pdf.bounds.left+bounds[:x], pdf.bounds.bottom+bounds[:y]+y], [pdf.bounds.left+bounds[:x]+bounds[:width], pdf.bounds.bottom+bounds[:y]+y]
        end

        unless options[:show_y] == false
          x = -0.5
          #pdf.text_mark "x #{x}"
          pdf.stroke_color = color
          pdf.line_width = stroke_width
          #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]+bounds[:height]}]"
          pdf.stroke_line [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]+bounds[:height]]
        end
        pdf.line_width = save_line_width
      end
    end # Axes

  end # Components
end # PrawnCharts

