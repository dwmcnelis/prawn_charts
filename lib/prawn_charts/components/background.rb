module PrawnCharts
  module Components
    class Background < Base
      def draw(pdf, bounds, options={})
        #fill = nil
        #case options[:theme].background
        #when Symbol, String
        #  fill = options[:theme].background.to_s
        #when Array
        #  fill = "url(#BackgroundGradient) #{options[:theme].background[0]}" # the second part is a fallback for Firefox, which does support gradient fills, but unfortunately can't handle url(#fragment) references for pdfs loaded from a data: URI (whereas it does work ok for external images); if we don't specify a solid fallback color it fills black!
        #  pdf.defs {
        #    pdf.linearGradient(:id=>'BackgroundGradient', :x1 => '0%', :y1 => '0%', :x2 => '0%', :y2 => '100%') {
        #      pdf.stop(:offset => '5%', 'stop-color' => options[:theme].background[0])
        #      pdf.stop(:offset => '95%', 'stop-color' => options[:theme].background[1])
        #    }
        #  }
        #end

        # Render background (maybe)
        puts "render background 0,0 #{bounds[:width]},#{bounds[:height]} #{options[:theme].background[0]} #{options[:theme].background[1]}"
        pdf.line_width = 5
        pdf.fill_color "F0FF00"
        pdf.fill_rectangle [300, 300], 200, 100
        pdf.fill_gradient [300, 300], 200, 100, 'F0FF00', '0000FF'
        pdf.fill_gradient [0,0], bounds[:width], bounds[:height],  'F0FF00', '0000FF' #unless fill.nil?
        pdf.fill_gradient [10, 330], 400, 50, 'F0FF00', '0000FF'
      end
    end
  end
end