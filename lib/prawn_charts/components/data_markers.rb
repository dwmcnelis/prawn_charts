
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class DataMarkers < Component
      DEFAULT_MARKER_FONT_SIZE = 5
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        #pdf.axis_marks

        if options[:calculate_markers] && (options[:point_markers].nil? || options[:point_markers].empty?)
          markers = (options[:markers] || self.markers) || 5
          options[:point_markers] = []
          each_marker(markers, options[:min_key], options[:max_key], bounds[:width], options, :key_formatter) do |label, x|
            options[:point_markers] << [x, label]
          end
        end
        unless options[:point_markers].nil?
          dx = bounds[:width].to_f / (options[:max_key] - options[:min_key] + 1)
          (0...options[:point_markers].size).map do |idx|
            x_coord = dx * (options[:point_markers][idx].first - options[:min_key]) + dx/2
            if options[:point_markers_ticks]
              save_line_width = pdf.line_width
              #pdf.text_mark "x #{x_coord}"
              pdf.stroke_color = options[:marker_color_override] || theme.marker || '000000'
              pdf.line_width = 1
              #pdf.text_mark "line stroke_line [#{pdf.bounds.left+bounds[:x]+x_coord}, #{pdf.bounds.bottom+bounds[:y]}], [#{pdf.bounds.left+bounds[:x]+x_coord}, #{pdf.bounds.bottom+bounds[:y]-3}]"
              pdf.stroke_line [pdf.bounds.left+bounds[:x]+x_coord, pdf.bounds.bottom+bounds[:y]], [pdf.bounds.left+bounds[:x]+x_coord, pdf.bounds.bottom+bounds[:y]-3]
              pdf.line_width = save_line_width
            end

            unless options[:point_markers][idx].nil?
              font_family = theme.font_family || "Helvetica"
              font_size = theme.marker_font_size ? relative(theme.marker_font_size) : relative(DEFAULT_MARKER_FONT_SIZE)
              text_color =  options[:marker_color_override] || theme.marker || '000000'
              angle =  options[:point_markers_rotation] || 0
              #pdf.text_mark("label #{label}, x #{bounds[:x]+bounds[:width]}, y #{bounds[:y]+y+font_size}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}  :align => :right")
              pdf.font(font_family) do
                pdf.fill_color text_color
                pdf.translate(pdf.bounds.left+bounds[:x]+x_coord,pdf.bounds.bottom+bounds[:y]+font_size) do
                  #pdf.rotate(angle, :origin => [0, 0]) do
                    pdf.text_box options[:point_markers][idx].last, :at => [0.0,0.0], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
                  #end
                end
              end
            end
          end
        end
      end
    end   # DataMarkers

  end # Components
end # PrawnCharts
