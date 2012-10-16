
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Title < Component
      TITLE_FONT_SIZE = 80

      def draw(pdf, bounds, options={})
        if (options[:marks])
          pdf.stroke_color 'ff0000'
          pdf.fill_color 'ff0000'
          pdf.fill_and_stroke_centroid([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]],:radius => 3)
          pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        end
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        font_family = theme.font_family || "Helvetica"
        if (theme.title_font_size)
          font_size = relative(theme.title_font_size)
        else
          font_size = relative(TITLE_FONT_SIZE)
        end
        text_color =  theme.title || '000000'
        if (options[:marks])
          #pdf.log_text("title #{options[:title]}, x #{bounds[:x]}, y #{bounds[:y]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
        end
        if options[:title]
          pdf.font(font_family) do
            pdf.fill_color text_color
            #pdf.text_box options[:title], :at => [bounds[:width]/2.0,bounds[:height]], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
            pdf.text_box options[:title], :at => [pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+font_size], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
        end
      end
    end # Title

  end # Components
end # PrawnCharts
