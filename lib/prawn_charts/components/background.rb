
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Background < Component
      def draw(pdf, bounds, options={})
        pdf.axis_marks
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        background = theme.background || ['ffffff','ffffff']
        start_color = background[0] || 'ffffff'
        stop_color = background[1] || 'ffffff'
        width = bounds[:width] || 540
        height = bounds[:height] || 720
        pdf.fill_gradient [0,height], width, height, start_color, 'ffffff'
        pdf.fill_rectangle [0,height], width, height
        pdf.stroke_color 'ff0000'
        pdf.crop_marks([0,height], width, height)
      end
    end # Background

  end # Components
end # PrawnCharts
