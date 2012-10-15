
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
          new PrawnCharts::Themes::Default.new
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

      # Returns a new PrawnCharts::Themes::Base object.
      #
      # Hash options:
      # background:: background color.
      # colors:: an array of color values to use for graphs.
      # marker:: color used for grid lines, values, data points, etc.
      # font_family:: in general, allows you to change the font used in the graph.
      #               This is not yet supported in most graph elements,
      #               and may be deprecated soon anyway.
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
      end

      # Returns the next available color in the color array.
      def next_color
        @previous_color = 0 if @previous_color.nil?
        @previous_color += 1

        self.colors[(@previous_color-1) % self.colors.size]
      end


      # Returns the next available outline in the outline array.
      def next_outline
        @previous_outline = 0 if @previous_outline.nil?
        @previous_outline += 1
        if self.outlines.nil?
          return '000000'
        end
        self.outlines[(@previous_outline-1) % self.outlines.size]
      end

      def darken(color, shift=20)
        shift_color(color,-(shift))
      end

      def lighten(color, shift=20)
        shift_color(color,(shift))
      end

      def shift_color(color,shift)
        r = color[0..1].hex+shift
        r = 255 if r > 255
        r = 0 if r < 0
        g = color[2..3].hex+shift
        g = 255 if g > 255
        g = 0 if g < 0
        b = color[4..5].hex+shift
        b = 255 if b > 255
        b = 0 if b < 0
        (("0"+r.to_s(16))[-2..-1])+(("0"+g.to_s(16))[-2..-1])+(("0"+b.to_s(16))[-2..-1])
      end
    end # Theme

  end # Themes
end # PrawnCharts
