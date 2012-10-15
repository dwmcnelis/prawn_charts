
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class XLegend < Component
      def draw(pdf, bounds, options={})
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        font_family = theme.font_family || "Helvetica"
        font_size = theme.legend_font_size || relative(100) #pdf.font_size
        text_color =  theme.marker || '000000'
        pdf.log_text("XLegend #{options[:title]}, x #{bounds[:width]/2.0}, y #{bounds[:height]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
        if options[:x_legend]
          pdf.font(font_family) do
            pdf.fill_color text_color
            pdf.text_box options[:x_legend], :at => [bounds[:width]/2.0,bounds[:height]], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
        end
        #if options[:title]
        #  pdf.text(options[:x_legend],
        #           :class => 'title',
        #  :x => (bounds[:width] / 2),
        #  :y => bounds[:height],
        #      'font-size' => options[:theme].legend_font_size || relative(100),
        #      'font-family' => options[:theme].font_family,
        #  :fill => options[:theme].marker,
        #  :stroke => 'none', 'stroke-width' => '0',
        #      'text-anchor' => (@options[:text_anchor] || 'middle'))
        #end
      end
    end #XLegend

  end # Components
end # PrawnCharts
