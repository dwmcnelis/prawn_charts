
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Area graph.
    class Area < Layer

      # Render area graph.
      def draw(pdf, coords, options={})
        options.merge!(@options)
        marker = options[:marker]
        marker_size = options[:marker_size] || 2
        marker_size = (options[:relative]) ? relative(marker_size) : marker_size
        pdf.reset_text_marks
        translated = [[coords.first.first,0]]
        coords.each do |x, y|
          translated << [x, height-y]
        end
        translated << [coords.last.first,0]
        theme.reset_color
        theme.next_color
        theme.next_color
        theme.next_color
        pdf.fill_color preferred_color || theme.next_color
        pdf.fill { pdf.polygon(*translated) }

        if options[:border]
          theme.reset_outline
          pdf.stroke_color theme.next_outline
          pdf.stroke { pdf.polygon(*translated) }
        end

        if marker
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), height-coord.last
            color = preferred_color || theme.next_color
            draw_marker(pdf,marker,x,y,marker_size,color)
          end
        end

      end

      def legend_data
        if relevant_data? && @color
          retval = []
          if titles && !titles.empty?
            titles.each_with_index do |stitle, index|
              retval << {:title => stitle,
                         :color => @colors[index],
                         :priority => :normal}
            end
          end
          retval
        else
          nil
        end
      end
    end # Area

  end # Layers
end # PrawnCharts