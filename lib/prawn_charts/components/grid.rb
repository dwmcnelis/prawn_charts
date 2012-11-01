
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Grid < Component
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        #pdf.axis_marks
        save_line_width = pdf.line_width
        markers = (options[:markers] || self.markers) || 5
        stroke_width = (options[:relative]) ? relative(options[:stroke_width]) : options[:stroke_width]
        color = theme.grid || theme.marker

        each_marker(markers, options[:min_value], options[:max_value], bounds[:height], options, :value_formatter) do |label, y|
          #pdf.text_mark "y #{y}"
          pdf.stroke_color = color
          pdf.line_width = stroke_width
          #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]}, #{pdf.bounds.bottom+bounds[:y]+y}], [#{pdf.bounds.left+bounds[:x]+bounds[:width]}, #{pdf.bounds.bottom+bounds[:y]+y}]"
          pdf.stroke_line [pdf.bounds.left+bounds[:x], pdf.bounds.bottom+bounds[:y]+y], [pdf.bounds.left+bounds[:x]+bounds[:width], pdf.bounds.bottom+bounds[:y]+y]
        end

        #add a 0 line
#        y = (options[:max_value] * bounds[:height])/(options[:max_value] - options[:min_value])
        #pdf.text_mark "y #{y}"
#        pdf.stroke_color = color
#        pdf.line_width = stroke_width
        #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]}, #{pdf.bounds.bottom+bounds[:y]+y}], [#{pdf.bounds.left+bounds[:x]+bounds[:width]}, #{pdf.bounds.bottom+bounds[:y]+y}]"
#        pdf.stroke_line [pdf.bounds.left+bounds[:x], pdf.bounds.bottom+bounds[:y]+y], [pdf.bounds.left+bounds[:x]+bounds[:width], pdf.bounds.bottom+bounds[:y]+y]

        pdf.line_width = save_line_width
      end
    end # Grid

  end # Components
end # PrawnCharts

