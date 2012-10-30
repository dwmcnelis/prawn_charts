
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Bar graph.
    class Bar < Layer

      # Draw bar graph.
      # Now handles positive and negative values gracefully.
      def draw(pdf, coords, options = {})
        #puts "bar draw options #{options.awesome_inspect}"
        options.merge!(@options)
        marker = options[:marker] || :circle
        marker_size = options[:marker_size] || 2
        marker_size = (options[:relative]) ? relative(marker_size) : marker_size
        pdf.reset_text_marks
        theme.reset_color
        coords.each_with_index do |coord,idx|
          next if coord.nil?
          color = preferred_color || theme.next_color

          x, y, bar_height = (coord.first), coord.last, 1#(height - coord.last)

          valh = max_value + min_value * -1 #value_height
          maxh = max_value * height / valh #positive area height
          minh = min_value * height / valh #negative area height
          #puts "height = #{height} and max_value = #{max_value} and min_value = #{min_value} and y = #{y} and point = #{points[idx]}"
          if points[idx] > 0
            bar_height = points[idx]*maxh/max_value
          else
            bar_height = points[idx]*minh/min_value
          end

          #pdf.text_mark "bar rect [#{x},#{y}], #{@bar_width}, #{bar_height}"
          pdf.centroid_mark([x+@bar_width/2.0,height-y-bar_height/2.0],:radius => 3)
          pdf.crop_marks([x,height-y],@bar_width,bar_height)

          current_color = color.is_a?(Array) ? color[idx % color.size] : color

          pdf.fill_color current_color
          #alpha = 1.0
          #pdf.transparent(alpha) do
          pdf.fill_rectangle([x,height-y], @bar_width, bar_height)
          #end
          if options[:border]
            theme.reset_outline
            pdf.stroke_color theme.next_outline
            pdf.stroke_rectangle([x,height-y], @bar_width, bar_height)
          end
        end

        if marker
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), height-coord.last
            color = preferred_color || theme.next_color
            draw_marker(pdf,marker,x+@bar_width/2.0,y,marker_size,color)
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

      # Due to the size of the bar graph, X-axis coords must
      # be squeezed so that the bars do not hang off the ends
      # of the graph.
      #
      # Unfortunately this just mean that bar-graphs and most other graphs
      # end up on different points.  Maybe adding a padding to the coordinates
      # should be a graph-wide thing?
      #
      # Update : x-axis coords for lines and area charts should now line
      # up with the center of bar charts.

      def generate_coordinates(options = {})
        #puts "bar generate_coordinates options #{options.awesome_inspect}"
        #puts "bar generate_coordinates @options #{@options.awesome_inspect}"
        dx = @options[:explode] ? relative(@options[:explode]) : 0
        @bar_width = (width / points.size)-dx
        options[:point_distance] = (width - @bar_width ) / (points.size - 1).to_f

        coords = (0...points.size).map do |idx|
          next if points[idx].nil?
          x_coord = (options[:point_distance] * idx) + (width / points.size * 0.5) - (@bar_width * 0.5)

          relative_percent = ((points[idx] == min_value) ? 0 : ((points[idx] - min_value) / (max_value - min_value).to_f))
          y_coord = (height - (height * relative_percent))
          [x_coord, y_coord]
        end
        coords
      end
    end # Bar

  end # Layers
end # PrawnCharts