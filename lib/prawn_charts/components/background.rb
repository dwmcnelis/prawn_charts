
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Background < Component
      def draw(pdf, bounds, options={})
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        #pdf.axis_marks
        start_color = theme.background[0] || 'ffffff'
        stop_color = theme.background[1] || 'ffffff'
        width = bounds[:width] || 540
        height = bounds[:height] || 720
        pdf.fill_gradient [0,height], width, height, start_color, stop_color
        pdf.fill_rectangle [0,height], width, height
        pdf.crop_marks([0,height], width, height)
      end
    end # Background

  end # Components
end # PrawnCharts
