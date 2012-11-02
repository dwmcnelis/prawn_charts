
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Column graph.
    class Column < Layer

      def draw(pdf, coords, options = {})
        #puts "column draw options #{options.awesome_inspect}"
        options.merge!(@options)
        marker = options[:marker] || :circle
        marker_size = options[:marker_size] || 2
        marker_size = (options[:relative]) ? relative(marker_size) : marker_size
        pdf.reset_text_marks
        theme.reset_color
        coords.each_with_index do |coord,idx|
          next if coord.nil?
          color = preferred_color || theme.next_color

          x, y, column_height = (coord.first), coord.last, 1#(height - coord.last)

          valh = max_value + min_value * -1 #value_height
          maxh = max_value * height / valh #positive area height
          minh = min_value * height / valh #negative area height
          #puts "height = #{height} and max_value = #{max_value} and min_value = #{min_value} and y = #{y} and point = #{points[idx]}"
          if points[idx] > 0
            column_height = points[idx]*maxh/max_value
          else
            column_height = points[idx]*minh/min_value
          end

          #pdf.text_mark "column rect [#{x},#{y}], #{@column_width}, #{column_height}"
          pdf.centroid_mark([x+@column_width/2.0,height-y-column_height/2.0],:radius => 3)
          pdf.crop_marks([x,height-y],@column_width,column_height)

          current_color = color.is_a?(Array) ? color[idx % color.size] : color

          pdf.fill_color current_color
          #alpha = 1.0
          #pdf.transparent(alpha) do
          pdf.fill_rectangle([x,height-y], @column_width, column_height)
          #end
          if options[:border]
            theme.reset_outline
            pdf.stroke_color theme.next_outline
            pdf.stroke_rectangle([x,height-y], @column_width, column_height)
          end
        end

        if marker
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), height-coord.last
            color = preferred_color || theme.next_color
            draw_marker(pdf,marker,x+@column_width/2.0,y,marker_size,color)
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

      protected

      # Due to the size of the column graph, X-axis coords must
      # be squeezed so that the columns do not hang off the ends
      # of the graph.
      #
      # Unfortunately this just mean that column-graphs and most other graphs
      # end up on different points.  Maybe adding a padding to the coordinates
      # should be a graph-wide thing?
      #
      # Update : x-axis coords for lines and area charts should now line
      # up with the center of column charts.

      def generate_coordinates(options = {})
        dx = @options[:explode] ? relative(@options[:explode]) : 0
        @column_width = (width / points.size)-dx
        options[:point_distance] = (width - @column_width ) / (points.size - 1).to_f

        coords = (0...points.size).map do |idx|
          next if points[idx].nil?
          x_coord = (options[:point_distance] * idx) + (width / points.size * 0.5) - (@column_width * 0.5) - dx/2.0

          relative_percent = ((points[idx] == min_value) ? 0 : ((points[idx] - min_value) / (max_value - min_value).to_f))
          y_coord = (height - (height * relative_percent))
          [x_coord, y_coord]
        end
        coords
      end
    end # Column

  end # Layers
end # PrawnCharts