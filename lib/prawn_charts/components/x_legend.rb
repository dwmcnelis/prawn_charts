
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class XLegend < Component
      def draw(pdf, bounds, options={})
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        font_family = theme.font_family || "Helvetica"
        font_size = theme.legend_font_size || relative(100) #pdf.font_size
        text_color =  theme.marker || '000000'
        pdf.text_mark("XLegend #{options[:title]}, x #{bounds[:width]/2.0}, y #{bounds[:height]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
        if options[:x_legend]
          pdf.font(font_family) do
            pdf.fill_color text_color
            pdf.text_box options[:x_legend], :at => [bounds[:width]/2.0,bounds[:height]], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
        end
      end
    end #XLegend

  end # Components
end # PrawnCharts
