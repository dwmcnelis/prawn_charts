
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Background < Component
      def draw(pdf, bounds, options={})
        pdf.axis_marks
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
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
