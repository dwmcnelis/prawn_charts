
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class ValueMarkers < Component
      DEFAULT_MARKER_FONT_SIZE = 5
      include PrawnCharts::Helpers::Marker

      attr_accessor :markers

      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        #pdf.axis_marks
        markers = (options[:markers] || self.markers) || 5
        each_marker(markers, options[:min_value], options[:max_value], bounds[:height], options, :value_formatter) do |label, y|
          font_family = theme.font_family || "Helvetica"
          font_size = theme.marker_font_size ? relative(theme.marker_font_size) : relative(DEFAULT_MARKER_FONT_SIZE)
          text_color =  options[:marker_color_override] || theme.marker || '000000'
          #pdf.text_mark("label #{label}, x #{bounds[:x]+bounds[:width]}, y #{bounds[:y]+y+font_size}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}  :align => :right")
          pdf.font(font_family) do
            pdf.fill_color text_color
            pdf.text_box options[:title], :at => [pdf.bounds.left+bounds[:x]+bounds[:width],pdf.bounds.bottom+bounds[:y]+y+font_size], :width =>  bounds[:width], :align => :right, :color => text_color, :size => font_size
          end
        end
      end
    end # ValueMarkers

  end # Components
end # PrawnCharts
