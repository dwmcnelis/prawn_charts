
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Legend < Component
      FONT_SIZE = 80

      def draw(pdf, bounds, options={})
        pdf.stroke_color 'ff0000'
        pdf.fill_color 'ff0000'
        pdf.centroid_mark([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]],:radius => 3)
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        vertical = options[:vertical_legend]
        legend_info = relevant_legend_info(options[:layers])
        @line_height, x, y, size = 0
        if vertical
          set_line_height = 0.08 * bounds[:height]
          @line_height = bounds[:height] / legend_info.length
          @line_height = set_line_height if @line_height > set_line_height
        else
          set_line_height = 0.90 * bounds[:height]
          @line_height = set_line_height
        end

        text_height = @line_height * FONT_SIZE / 100
        # #TODO how does this related to @points?
        active_width, points = layout(legend_info, vertical)

        offset = (bounds[:width] - active_width) / 2    # Nudge over a bit for true centering

        # Render Legend
        points.each_with_index do |point, idx|
          if vertical
            x = 0
            y = point
            size = @line_height * 0.5
          else
            x = offset + point
            y = 0
            size = relative(50)
          end

          # "#{x} #{y} #{@line_height} #{size}"
          theme = options[:theme] || PrawnCharts::Themes::Theme.default
          color = legend_info[idx][:color]
          pdf.fill_color = color
          pdf.fill_rectangle [pdf.bounds.left+bounds[:x]+x,pdf.bounds.bottom+bounds[:y]+y+size], size, size
          #pdf.rect(:x => x,
          #         :y => y,
          #         :width => size,
          #         :height => size,
          #         :fill => legend_info[idx][:color])
          font_family = theme.font_family || "Helvetica"
          font_size = text_height
          text_color =  theme.marker || 'fffffff'
          pdf.stroke_color 'ff0000'
          pdf.fill_color 'ff0000'
          pdf.centroid_mark([pdf.bounds.left+bounds[:x]+x+2*size,pdf.bounds.bottom+bounds[:y]+y+size],:radius => 3)
          pdf.crop_marks([pdf.bounds.left+bounds[:x]+x+2*size,pdf.bounds.bottom+bounds[:y]+y+size],bounds[:width]-2*size,font_size)
          #pdf.text_mark("Legend #{options[:title]}, x #{bounds[:width]/2.0}, y #{bounds[:height]}, w #{ bounds[:width]}, font_family #{font_family}, font_size #{font_size}, text_color #{text_color}")
          pdf.font(font_family) do
            pdf.fill_color text_color
            #pdf.text_box legend_info[idx][:title], :at => [x + @line_height,y + text_height * 0.75], :width =>  bounds[:width], :align => :left, :color => text_color, :size => font_size
            pdf.text_box legend_info[idx][:title], :at => [pdf.bounds.left+bounds[:x]+x+2*size,pdf.bounds.bottom+bounds[:y]+y+size], :width =>  bounds[:width]-2*size, :align => :left, :color => text_color, :size => font_size
            #pdf.text_box options[:title], :at => [pdf.bounds.left+bounds[:x],pdf.bounds.top-bounds[:y]], :width =>  bounds[:width], :align => :center, :color => text_color, :size => font_size
          end
          #pdf.text(legend_info[idx][:title],
          #         :x => x + @line_height,
          #         :y => y + text_height * 0.75,
          #  'font-size' => text_height,
          #  'font-family' => options[:theme].font_family,
          #:style => "color: #{options[:theme].marker || 'white'}",
          #:fill => (options[:theme].marker || 'white'))
        end
      end   # draw

      protected
            # Collects Legend Info from the provided Layers.
            #
            # Automatically filters by legend's categories.
      def relevant_legend_info(layers, categories=(@options[:category] ? [@options[:category]] : @options[:categories]))
        legend_info = layers.inject([]) do |arr, layer|
          if categories.nil? ||
            (categories.include?(layer.options[:category]) ||
              (layer.options[:categories] && (categories & layer.options[:categories]).size > 0) )

            data = layer.legend_data
            arr << data if data.is_a?(Hash)
            arr = arr + data if data.is_a?(Array)
          end
          arr
        end
      end   # relevant_legend_info

      # Returns an array consisting of the total width needed by the legend
      # information, as well as an array of @x-coords for each element. If
      # vertical, then these are @y-coords, and @x is 0
      #
      # ie: [200, [0, 50, 100, 150]]
      def layout(legend_info_array, vertical = false)
        if vertical
          longest = 0
          legend_info_array.each {|elem|
            cur_length = relative(50) * elem[:title].length
            longest = longest < cur_length ? cur_length : longest
          }
          y_positions = []
          (0..legend_info_array.length - 1).each {|y|
            y_positions << y * @line_height
          }
          [longest, y_positions]
        else
          legend_info_array.inject([0, []]) do |enum, elem|
            enum[0] += (relative(50) * 2) if enum.first != 0      # Add spacer between elements
            enum[1] << enum.first                                 # Add location to points
            enum[0] += relative(50)                               # Add room for color box
            enum[0] += (relative(50) * elem[:title].length)       # Add room for text

            [enum.first, enum.last]
          end
        end
      end

    end # Legend

  end # Components
end # PrawnCharts
