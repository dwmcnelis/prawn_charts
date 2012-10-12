module PrawnCharts
  module Components
    class Title < Base
      def draw(pdf, bounds, options={})
        @theme = options[:theme] || PrawnCharts::Themes::Theme.default
        @font_family = @theme.font_family || "Helvetica"
        @font_size = @theme.title_font_size || pdf.font_size
        @text_color =  @theme.title || '000000'
        pdf.log_text "title #{options[:title]}, x #{bounds[:width]/2.0}, y #{bounds[:height]}, w #{ bounds[:width]}, color #{@text_color}"

        if options[:title]
          pdf.fill_color @text_color
          pdf.font(@font_family) do
            pdf.text_box options[:title], :at => [bounds[:width]/2.0,bounds[:height]], :width =>  bounds[:width], :align => :center, :color => @theme.title, :size => @theme.title_font_size
          end
        end
      end
    end
  end
end