
# PrawnCharts Themes allow you to alter the colors and appearances of
# your graph.
module PrawnCharts
  module Themes

    # The theme base class.  Most themes can be constructed simply
    # by instantiating a new Base object with a hash of color values.
    #
    # See PrawnCharts::Themes::Theme#instantiate for examples.
    class Theme
      # class methods
      class << self
        def default
          PrawnCharts::Themes::Default.new
        end
      end # class methods
      attr_accessor :background     # Background color or array of two colors
      attr_accessor :colors         # Array of colors for data graphs
      attr_accessor :outlines       # Array of colors for outlines of elements for data graphs
      attr_accessor :title          # Title color for graphs
      attr_accessor :grid           # Marker color for grid lines, etc.
      attr_accessor :marker         # Marker color for grid lines, values, etc.
      attr_accessor :font_family    # Font family: Not really supported.  Maybe in the future.
      attr_accessor :marker_font_size    # Marker Font Size:
      attr_accessor :title_font_size    # Title Font Size:
      attr_accessor :legend_font_size    # Legend Font Size:
      attr_accessor :stacked_opacity    # Opacity for stacked graphs:

      # Returns a new PrawnCharts::Themes::Base object.
      #
      # Hash options:
      # background:: background color.
      # colors:: an array of color values to use for graphs.
      # marker:: color used for grid lines, values, data points, etc.
      # font_family:: font family used in the graph.
      def initialize(descriptor)
        self.background = descriptor[:background]
        self.colors     = descriptor[:colors]
        self.outlines     = descriptor[:outlines]
        self.title     = descriptor[:title]
        self.grid     = descriptor[:grid]
        self.marker     = descriptor[:marker]
        self.font_family = descriptor[:font_family]
        self.marker_font_size = descriptor[:marker_font_size]
        self.title_font_size = descriptor[:title_font_size]
        self.legend_font_size = descriptor[:legend_font_size]
        self.stacked_opacity = descriptor[:stacked_opacity]
      end

      # Resets colors to beginning
      def reset_color
        @previous_color = 0
      end

      # Returns the next available color in the color array.
      def next_color
        @previous_color = 0 if @previous_color.nil?
        @previous_color += 1
        return '000000' if self.colors.nil?
        self.colors[(@previous_color-1) % self.colors.size]
      end


      # Resets outline color to beginning
      def reset_outline
        @previous_outline = 0
      end

      # Returns the next available outline in the outline array.
      def next_outline
        @previous_outline = 0 if @previous_outline.nil?
        @previous_outline += 1
        return '000000' if self.outlines.nil?
        self.outlines[(@previous_outline-1) % self.outlines.size]
      end

      def darken(color, shift=20)
        shift_color(color,-(shift))
      end

      def lighten(color, shift=20)
        shift_color(color,(shift))
      end

      def gradient(start,stop,steps=10)
        palette = {}
        start_r, start_g, start_b = parse_color(start)
        stop_r, stop_g, stop_b = parse_color(stop)
        delta_r = (stop_r-start_r)/steps
        delta_g = (stop_g-start_g)/steps
        delta_b = (stop_b-start_b)/steps

        palette[:start] = start
        index = 1
        until index >= steps  do
          r = start_r+(index*delta_r)
          g = start_g+(index*delta_g)
          b = start_b+(index*delta_b)
          palette["step#{index}".to_sym] = colors_to_s(r,g,b)
          index += 1
        end
        palette[:stop] = stop
        palette
      end

      def shift_color(color,shift)
        r, g, b = parse_color(color)
        r = bounded_color(r+shift)
        g = bounded_color(g+shift)
        b = bounded_color(b+shift)
        colors_to_s(r,g,b)
      end
    end # Theme

    def bounded_color(color)
      color = 255 if color > 255
      color = 0 if color < 0
    end

    def parse_color(color)
      r = color[0..1].hex
      g = color[2..3].hex
      b = color[4..5].hex
      return r, g, b
    end

    def colors_to_s(r,g,b)
      (("0"+r.to_s(16))[-2..-1])+(("0"+g.to_s(16))[-2..-1])+(("0"+b.to_s(16))[-2..-1])
    end
  end # Themes
end # PrawnCharts
