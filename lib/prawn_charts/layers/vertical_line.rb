
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Vertical line graph.
    class VerticalLine < Layer

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
                pdf.stroke_line [py+offset, height-px-offset], [y+offset, height-x-offset]
              end
            end
            px, py = x, y
          end
          if marker
            theme.reset_color
            coords.each do |coord|
              x, y = (coord.first)+offset, height-coord.last-offset
              color = preferred_color || theme.next_color
              draw_marker(pdf,marker,y,x,marker_size,color)
            end
          end
        end

        px, py = (coords[0].first), coords[0].last
        coords.each_with_index do |coord,index|
          x, y = (coord.first), coord.last
          unless index == 0
            #pdf.text_mark "line stroke_line [#{px}, #{height-py}], [#{x}, #{height-y}]"
            pdf.stroke_color = outline_color
            pdf.stroke_line [py, height-px], [y, height-x]
          end
          px, py = x, y
        end
        if marker
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), height-coord.last
            color = preferred_color || theme.next_color
            draw_marker(pdf,marker,y,x,marker_size,color)
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

      def generate_coordinates(options = {})
        dx = height.to_f / (options[:max_value] - options[:min_value])
        dy = width.to_f / (options[:max_key] - options[:min_key] + 1)

        coords = []
        points.each_point do |x, y|
          if y
            y_coord = dy * (y - options[:min_key]) + dy/2
            x_coord = dx * (x - options[:min_value])

            coords << [y_coord, height - x_coord]
          end
        end
        puts "vertical_line generate_coordinates coords #{coords.awesome_inspect}"
        coords
      end
      def generate_coordinates(options = {})
        dy = height.to_f / (options[:max_value] - options[:min_value])
        dx = width.to_f / (options[:max_key] - options[:min_key] + 1)

        ret = []
        points.each_point do |x, y|
          if y
            x_coord = dx * (x - options[:min_key]) + dx/2
            y_coord = dy * (y - options[:min_value])

            ret << [x_coord, height - y_coord]
          end
        end
        return ret
      end
    end # VerticalLine

  end # Layers
end # PrawnCharts