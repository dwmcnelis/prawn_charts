
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class VerticalGrid < Component
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        #pdf.axis_marks
        save_line_width = pdf.line_width
        markers = (options[:key_markers] || self.markers) || 5
        stroke_width = (options[:relative]) ? relative(options[:stroke_width]) : options[:stroke_width]
        color = theme.grid || theme.marker

        if options[:graph].point_markers #get vertical grid lines up with points if there are labels for them
          point_distance = bounds[:width] / (options[:graph].point_markers.size).to_f
          stroke_width = options[:stroke_width]
          (0...options[:graph].point_markers.size).map do |idx|
            x = point_distance * idx  + point_distance/2
            #pdf.text_mark "x #{x}"
            pdf.stroke_color = color
            pdf.line_width = stroke_width
            #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]+bounds[:height]}]"
            pdf.stroke_line [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]+bounds[:height]]
          end
          #add the far right and far left lines
          x = 0
          #pdf.text_mark "x #{x}"
          pdf.stroke_color = color
          pdf.line_width = stroke_width
          #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]+bounds[:height]}]"
          pdf.stroke_line [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]+bounds[:height]]
          x = bounds[:width]
          #pdf.text_mark "x #{x}"
          pdf.stroke_color = color
          pdf.line_width = stroke_width
          #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]+bounds[:height]}]"
          pdf.stroke_line [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]+bounds[:height]]
        else

          each_marker(markers, options[:min_key], options[:max_key], bounds[:width], options, :key_formatter) do |label, x|
            #pdf.text_mark "x #{x}"
            pdf.stroke_color = color
            pdf.line_width = stroke_width
            #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x}, #{pdf.bounds.bottom+bounds[:y]+bounds[:height]}]"
            pdf.stroke_line [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x, pdf.bounds.bottom+bounds[:y]+bounds[:height]]
          end

          pdf.line_width = save_line_width
        end
      end
    end # Vertical Grid

  end # Components
end # PrawnCharts

