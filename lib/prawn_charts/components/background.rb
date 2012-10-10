module PrawnCharts
  module Components
    class Background < Base
      def draw(pdf, bounds, options={})
        #pdf.text_box "Background.draw bounds #{bounds}, options #{options}", :at => [10, 600]
        # Render background (maybe)
        if options[:theme].background.class == Array
          pdf.fill_gradient [0,bounds[:height]], bounds[:width], bounds[:height], options[:theme].background[0], options[:theme].background[1]
          pdf.fill_rectangle [0,bounds[:height]], bounds[:width], bounds[:height]
        end
      end
    end
  end
end