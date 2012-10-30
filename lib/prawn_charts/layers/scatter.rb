
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Scatter graph.
    class Scatter < Layer

      # Renders scatter graph.
      #
      # Options:
      # See initialize()
      def draw(pdf, coords, options={})

        # Include options provided when the object was created
        options.merge!(@options)
        pdf.reset_text_marks
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        marker = options[:marker] || :circle
        marker_size = options[:marker_size] || 2
        marker_size = (options[:relative]) ? relative(marker_size) : marker_size
        save_line_width = pdf.line_width

        if options[:shadow]
          offset = 2
          theme.reset_color
          coords.each do |coord|
            x, y = (coord.first), coord.last
            pdf.fill_color = preferred_color || theme.next_color
            pdf.fill_circle [x+offset, height-y-offset], dot_radius
          end
        end

        theme.reset_color
        coords.each do |coord|
          x, y = (coord.first), coord.last
          color = preferred_color || theme.next_color
          draw_marker(pdf,marker,x,y,marker_size,color)
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
    end # Scatter

  end # Layers
end # PrawnCharts
