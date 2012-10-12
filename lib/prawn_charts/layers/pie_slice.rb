module PrawnCharts::Layers
  # Basic Pie Chart Slice..
    
  class PieSlice < Base
    HALF_PI = Math::PI/2.0
    THREE_HALVES_PI = 3.0/2.0*Math::PI
    TWO_PI = 2.0*Math::PI
    MARKER_OFFSET_RATIO = 1.2
    MARKER_FONT_SIZE = 6
    
    attr_accessor :diameter
    attr_accessor :percent_used
    attr_accessor :offset_angle
    attr_accessor :scaler
    attr_accessor :center_x, :center_y
    
    def draw(pdf, coords, options = {})
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

      theme = options[:theme]

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
      start_angle = (@percent_used/100.0*TWO_PI+@offset_angle) % TWO_PI
      # Calculate the Radian End Point
      end_angle = ((@percent_used+percent)/100.0*TWO_PI+@offset_angle) % TWO_PI
      end_angle = end_angle + TWO_PI if end_angle < start_angle

      mid_angle = (start_angle+((end_angle-start_angle)/2.0)) % TWO_PI

      dx = options[:explode] ? (Math.cos(mid_angle)*relative(options[:explode])) : 0
      dy = options[:explode] ? (Math.sin(mid_angle)*relative(options[:explode])) : 0

      @center_x  = @center_x + dx + shift_x
      @center_y  = @center_y + dy + shift_y

      # Calculate the beginning coordinates
      x_start = @center_x + (Math.cos(start_angle)*radius)
      y_start = @center_y + (Math.sin(start_angle)*radius)
      
      # Calculate the End Coords
      x_end = @center_x + (Math.cos(end_angle)*radius)
      y_end = @center_y + (Math.sin(end_angle)*radius)

      # If percentage is really really close to 100% then draw a circle instead!
      if percent >= 99.9999
        
        #if shadow
        #  pdf.circle(:cx => "#{@center_x + shadow_x}", :cy => "#{@center_y + shadow_y}", :r=>"#{radius}",:stroke => "none",
        #    :fill => shadow_color.to_s,  :style => "fill-opacity: #{shadow_opacity.to_s};")
        #end
        
        #pdf.circle(:cx => "#{@center_x}", :cy => "#{@center_y}", :r=>"#{radius}",:stroke => stroke, :fill => color.to_s)

      else  
        #if shadow
        #  pdf.path(:d =>  "M#{@center_x + shadow_x},#{@center_y + shadow_y} L#{x_start + shadow_x},#{y_start + shadow_y} A#{radius},#{radius} 0, #{percent >= 50 ? '1' : '0'}, 1, #{x_end + shadow_x} #{y_end + shadow_y} Z",
        #    :fill => shadow_color.to_s, :style => "fill-opacity: #{shadow_opacity.to_s};")
        #end
        slate_blue = "294651"
        blue20 = "3d5a65"
        blue40 = "516e79"
        blue60 = "65828d"
        blue80 = "7996a1"
        blue100 = "8daab5"
        blue120 = "a1bec9"
        blue140 = "b5d2dd"
        blue160 = "c9e6f1"
        pale_blue = "ccd0d2"
        paleblue20 = "c9e6f1"
        paleblue40 = "f4f8fa"

        center = [@center_x,@center_y]
        pdf.stroke_color theme.outlines[0]
        pdf.fill_color color
        pdf.fill_pie_slice(center,
                       :radius => radius,
                       :start_angle => start_angle,
                       :end_angle => end_angle)
        pdf.stroke_pie_slice(center,
                         :radius => radius,
                         :start_angle => start_angle,
                         :end_angle => end_angle,:stroke_both_sides => true)
        #point = pie_offset(center,
        #                   :radius => radius,
        #                   :offset => radius+30-20,
        #                   :start_angle => start_angle,
        #                   :end_angle => end_angle)
        #fill_color slate_blue
        #text_box "$175,000", :at => point, :width => 200


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
      text_color = (theme.marker || '000000').to_s
      #w = bounds[:width]   :width => w,
      pdf.fill_color text_color
      pdf.text_box "#{sprintf('%d', percent)}%", :at => [text_x-relative(4),text_y+relative(MARKER_FONT_SIZE/2)-relative(3)], :width => 30, :align => :center, :color => text_color

    end

    protected
    def generate_coordinates(options = {})
    end
  end
  
end