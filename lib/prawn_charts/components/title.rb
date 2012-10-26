
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Title < Component
      TITLE_FONT_SIZE = 80

      def draw(pdf, bounds, options={})
        pdf.centroid_mark([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        font_family = theme.font_family || "Helvetica"
        if (theme.title_font_size)
          font_size = relative(theme.title_font_size)
        else
          font_size = relative(TITLE_FONT_SIZE)
        end
        text_color =  theme.title || '000000'
        #pdf.text_mark("title #{options[:title]}, x #{bounds[:x]}, y #{bounds[:y]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
        if options[:title]
          pdf.font(font_family) do
            pdf.fill_color text_color
            pdf.text_box options[:title], :at => [pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+font_size], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
        end
      end
    end # Title

  end # Components
end # PrawnCharts
