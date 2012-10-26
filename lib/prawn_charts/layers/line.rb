
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

        stroke_width = (options[:relativestroke]) ? relative(options[:stroke_width]) : options[:stroke_width]
        style = (options[:style]) ? options[:style] : ''

        save_line_width = pdf.line_width
        pdf.line_width = stroke_width
        #pdf.dash(length, :space => space, :phase => phase)
        pdf.reset_text_marks
        #pdf.text_mark "line move_to x #{x}, y #{height-y}"
        #puts "line move_to x #{x}, y #{height-y}"
        #pdf.move_to x, height-y
        px, py = (coords[0].first), coords[0].last
        @colors = []
        coords.each_with_index do |coord,index|
          x, y = (coord.first), coord.last
          color = preferred_color || color || options[:theme].next_color
          @colors << color
          unless index == 0
            #pdf.fill_color = color
            #pdf.stroke_line_to x, height-y
            pdf.text_mark "line stroke_line [#{px}, #{height-py}], [#{x}, #{height-y}]"
            puts "line stroke_line [#{px}, #{height-py}], [#{x}, #{height-y}]"
            puts "line @color #{color.awesome_inspect}"
            pdf.stroke_color = color
            pdf.stroke_line [px, height-py], [x, height-y]
          end
          px, py = x, y
        end

        #pdf.polyline( :points => stringify_coords(coords).join(' '), :fill => 'none', :stroke => @color.to_s,'stroke-width' => stroke_width, :style => style  )

        if options[:shadow]
          #pdf.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
          #  pdf.polyline( :points => stringify_coords(coords).join(' '), :fill => 'transparent',
          #    :stroke => 'black', 'stroke-width' => stroke_width,
          #    :style => 'fill-opacity: 0; stroke-opacity: 0.35' )
          #
          #  if options[:dots]
          #    coords.each { |coord| pdf.circle( :cx => coord.first, :cy => coord.last + relative(0.9), :r => stroke_width,
          #      :style => "stroke-width: #{stroke_width}; stroke: black; opacity: 0.35;" ) }
          #  end
          #}
        end

        if options[:dots]
          coords.each do |coord|
            #pdf.circle( :cx => coord.first, :cy => coord.last, :r => stroke_width, :style => "stroke-width: #{stroke_width}; stroke: #{color.to_s}; fill: #{color.to_s}" )
          end
        end
        pdf.line_width = save_line_width

      end
    end # Line

  end # Layers
end # PrawnCharts