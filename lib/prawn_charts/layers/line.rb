
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Line graph.
    class Line < Layer

      # Renders line graph.
      #
      # Options:
      # See initialize()
      def draw(pdf, coords, options={})

        # Include options provided when the object was created
        options.merge!(@options)
        pdf.reset_text_marks
        stroke_width = (options[:relative]) ? relative(options[:stroke_width]) : options[:stroke_width]
        marker = options[:marker]
        marker_size = options[:marker_size] || 2
        marker_size = (options[:relative]) ? relative(marker_size) : marker_size
        style = (options[:style]) ? options[:style] : ''
        theme.reset_outline
        outline_color = theme.next_outline
        save_line_width = pdf.line_width
        pdf.line_width = stroke_width
        #pdf.dash(length, :space => space, :phase => phase)

        if options[:shadow]
          offset = 2
          px, py = (coords[0].first), coords[0].last
          coords.each_with_index do |coord,index|
            x, y = (coord.first), coord.last
            unless index == 0
              pdf.transparent(0.5) do
                pdf.stroke_color = outline_color
                pdf.stroke_line [px+offset, height-py-offset], [x+offset, height-y-offset]
              end
            end
            px, py = x, y
          end
          if marker
            theme.reset_color
            coords.each do |coord|
              x, y = (coord.first)+offset, height-coord.last-offset
              color = preferred_color || theme.next_color
              draw_marker(pdf,marker,x,y,marker_size,color)
            end
          end
        end

        px, py = (coords[0].first), coords[0].last
        coords.each_with_index do |coord,index|
          x, y = (coord.first), coord.last
          unless index == 0
            #pdf.text_mark "line stroke_line [#{px}, #{height-py}], [#{x}, #{height-y}]"
            pdf.stroke_color = outline_color
            pdf.stroke_line [px, height-py], [x, height-y]
          end
          px, py = x, y
        end
        if marker
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), height-coord.last
            color = preferred_color || theme.next_color
            draw_marker(pdf,marker,x,y,marker_size,color)
          end
        end

        pdf.line_width = save_line_width
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
    end # Line

  end # Layers
end # PrawnCharts