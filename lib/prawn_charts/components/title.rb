
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Title < Component
      def draw(pdf, bounds, options={})
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        font_family = theme.font_family || "Helvetica"
        font_size = theme.title_font_size || pdf.font_size
        text_color =  theme.title || '000000'
        pdf.log_text("Title #{options[:title]}, x #{bounds[:width]/2.0}, y #{bounds[:height]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
        if options[:title]
          pdf.font(font_family) do
            pdf.fill_color text_color
            pdf.text_box options[:title], :at => [bounds[:width]/2.0,bounds[:height]], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
        end
      end
    end # Title

  end # Components
end # PrawnCharts
