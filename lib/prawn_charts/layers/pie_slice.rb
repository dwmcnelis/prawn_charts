
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Basic Pie Chart Slice..
    class PieSlice < Layer
      MARKER_OFFSET_RATIO = 1.25
      MARKER_FONT_SIZE = 6

      attr_accessor :diameter
      attr_accessor :percent_used
      attr_accessor :offset_angle
      attr_accessor :scaler
      attr_accessor :center_x, :center_y

      def draw(pdf, coords, options = {})
        #pdf.text_mark "pie_slice coords #{coords}, options #{options}"
        theme = options[:theme] || PrawnCharts::Themes::Theme.default
        # Scaler is the multiplier to normalize the values to a percentage across
        # the Pie Chart
        @scaler = options[:scaler] || 1

        # Degree Offset is degrees by which the pie chart is twisted when it
        # begins
        @offset_angle = options[:offset_angle] || @options[:offset_angle] || 0

        # Percent Used keeps track of where in the pie chart we are
        @percent_used = options[:percent_used] || @options[:percent_used] || 0

        # Diameter of the pie chart defaults to 70% of the height
        @diameter = relative(options[:diameter]) || relative(@options[:diameter]) || relative(70.0)


        # Stroke
        stroke = options[:stroke] || @options[:stroke] || "none"

        # Shadow
        shadow = options[:shadow] || @options[:shadow_] || false
        shadow_x = relative(options[:shadow_x]) || relative(@options[:shadow_x]) || relative(-0.5)
        shadow_y = relative(options[:shadow_y]) || relative(@options[:shadow_y]) || relative(0.5)
        shadow_color = options[:shadow_color] || @options[:shadow_color] || 'ffffff'
        shadow_opacity = options[:shadow_opacity] || @options[:shadow_opacity] || 0.06

        # Coordinates for the center of the pie chart.
        @center_x = relative_width(options[:center_x]) || relative_width(@options[:center_x]) || relative_width(50)
        @center_y = relative_height(options[:center_y]) || relative_height(@options[:center_y]) || relative_height(50)
        radius = @diameter/2.0
        shift_x = 0+4.0
        shift_y = (relative_height(100)-@diameter)/2.0-20.0

        # Graphing calculated using percent of graph. We later multiply by 2.0*Math::PI to
        # convert to radians.
        percent = @scaler*sum_values

        # Calculate the Radian Start Point
        start_angle = (@percent_used/100.0*Math::TWO_PI+@offset_angle) % Math::TWO_PI
        # Calculate the Radian End Point
        end_angle = ((@percent_used+percent)/100.0*Math::TWO_PI+@offset_angle) % Math::TWO_PI
        end_angle = end_angle + Math::TWO_PI if end_angle < start_angle

        mid_angle = (start_angle+((end_angle-start_angle)/2.0)) % Math::TWO_PI

        dx = options[:explode] ? (Math.cos(mid_angle)*relative(options[:explode])) : 0
        dy = options[:explode] ? (Math.sin(mid_angle)*relative(options[:explode])) : 0

        @center_x  = @center_x + dx #+ shift_x
        @center_y  = @center_y + dy #+ shift_y

        # Calculate the beginning coordinates
        x_start = @center_x + (Math.cos(start_angle)*radius)
        y_start = @center_y + (Math.sin(start_angle)*radius)

        # Calculate the End Coords
        x_end = @center_x + (Math.cos(end_angle)*radius)
        y_end = @center_y + (Math.sin(end_angle)*radius)

        center = [@center_x,@center_y]
        text_x = @center_x + (Math.cos(mid_angle)*radius*MARKER_OFFSET_RATIO)
        text_y = @center_y + (Math.sin(mid_angle)*radius*MARKER_OFFSET_RATIO)

        pdf.stroke_color 'ff0000'
        pdf.fill_color 'ff0000'
        pdf.centroid_mark(center,:radius => 3)

        # If percentage is really really close to 100% then draw a circle instead!
        if percent >= 99.9999

          #if shadow
          #  pdf.circle(:cx => "#{@center_x + shadow_x}", :cy => "#{@center_y + shadow_y}", :r=>"#{radius}",:stroke => "none",
          #    :fill => shadow_color.to_s,  :style => "fill-opacity: #{shadow_opacity.to_s};")
          #end

          pdf.stroke_color theme.outlines[0]
          pdf.fill_color color
          pdf.fill_and_stroke_circle center, radius
          #pdf.circle(:cx => "#{@center_x}", :cy => "#{@center_y}", :r=>"#{radius}",:stroke => stroke, :fill => color.to_s)

        else
          #if shadow
          #  pdf.path(:d =>  "M#{@center_x + shadow_x},#{@center_y + shadow_y} L#{x_start + shadow_x},#{y_start + shadow_y} A#{radius},#{radius} 0, #{percent >= 50 ? '1' : '0'}, 1, #{x_end + shadow_x} #{y_end + shadow_y} Z",
          #    :fill => shadow_color.to_s, :style => "fill-opacity: #{shadow_opacity.to_s};")
          #end

          pdf.stroke_color theme.outlines[0]
          pdf.stroke { pdf.pie_slice(center,
            :radius => radius,
            :start_angle => start_angle,
            :end_angle => end_angle,:stroke_both_sides => true) }
          pdf.fill_color color
          pdf.fill { pdf.pie_slice(center,
            :radius => radius,
            :start_angle => start_angle,
            :end_angle => end_angle) }

          #pdf.path(:d =>  "M#{@center_x},#{@center_y} L#{x_start},#{y_start} A#{radius},#{radius} 0, #{percent >= 50 ? '1' : '0'}, 1, #{x_end} #{y_end} Z",
          #  :stroke => stroke, :fill => color.to_s)
        end

        text_x = @center_x + (Math.cos(mid_angle)*radius*MARKER_OFFSET_RATIO)
        text_y = @center_y + (Math.sin(mid_angle)*radius*MARKER_OFFSET_RATIO)

        #pdf.text("#{sprintf('%d', percent)}%",
        #  :x => text_x,
        #  :y => text_y + relative(MARKER_FONT_SIZE / 2),
        #  'font-size' => relative(MARKER_FONT_SIZE),
        #  'font-family' => options[:theme].font_family,
        #  :fill => (options[:theme].marker || 'black').to_s,
        #  'text-anchor' => 'middle')
        font_family = theme.font_family || "Helvetica"
        font_size = relative(MARKER_FONT_SIZE)
        width = font_size*4
        text_color =  theme.marker || '000000'
        dx = -width/2
        dy = font_size/2
        pdf.font(font_family) do
          pdf.fill_color text_color
          pdf.text_box "#{sprintf('%d', percent)}%", :at => [text_x+dx,text_y+dy], :width => width, :align => :center, :color => text_color, :size => font_size
        end
        pdf.stroke_color 'ff0000'
        pdf.crop_marks([text_x+dx,text_y+dy],width,font_size)
      end

      protected
      def generate_coordinates(options = {})
      end
    end # Layer

  end # Layers
end # PrawnCharts