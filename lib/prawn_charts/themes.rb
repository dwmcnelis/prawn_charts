# PrawnCharts Themes allow you to alter the colors and appearances of
# your graph.
module PrawnCharts::Themes
  
  # The base theme class.  Most themes can be constructed simply
  # by instantiating a new Base object with a hash of color values.
  #
  # See PrawnCharts::Themes::Base#instantiate for examples.
  class Base
    attr_accessor :background     # Background color or array of two colors
    attr_accessor :colors         # Array of colors for data graphs
    attr_accessor :outlines       # Array of colors for outlines of elements for data graphs
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
        return "#000000"
      end
      self.outlines[(@previous_outline-1) % self.outlines.size]
    end

    # TODO: Implement darken function.
    def darken(color, shift=20); end
    
    # TODO: Implement lighten function.
    def lighten(color, shift=20); end
    
  end
  

  
  # A basic default theme
  # Based on http://www.wellstyled.com/tools/colorscheme2/index-en.html?tetrad;50;0;255;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;0
  class Standard < Base
    def initialize
      super({
              :background => ['ffffff', 'ffffff'],
              :marker => '999999',
              :colors => %w(1919b3 ffb200 ffff00 660099 e9e9ff fff7e6 ffffe6 f7e6ff 0f0f6b 996b00 999900 3d005c)
            })
    
    end
  end
  
  # Keynote theme, based on Apple's Keynote presentation software.
  #
  # Color values used from Gruff's default theme.
  class Keynote < Base
    def initialize
      super({  
              :background => ['000000', '4a465a'],
              :marker => 'ffffff', 
              :colors => %w(6886b4 fdd84e 72ae6e d1695e 8a6eaf efaa43 ffffff)
             })
    end
  end

  # Roughly, roughly based on the color scheme of www.mephistoblog.com.
  class Mephisto < Base
    def initialize
      super({
              :background => ['101010', '999977'],
              :marker => 'ffffff',
              :colors => %w(dd3300 66aabb 225533 992200)
            })
      
    end
  end
  
  # Based on the color scheme used by almost every Ruby blogger.
  class RubyBlog < Base
    def initialize
      super({
              :background => ['670a0a', '831515'],
              :marker => 'dbd1c1',
              :colors => %w(007777 444477 994444 77ffbb d75a20)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Apples < Base
    def initialize
      super({
              :background => ['3b411f', '4a465a'],
              :marker => 'dbd1c1',
              :colors => %w(aa3322 dd3322 dd6644 ffee88 bbcc66 779933)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/  
  class CareBears < Base
    def initialize
      super({
              # Playing with Sky Background
              # :background => ['2774b6', '5ea6d8'],
              # :marker => 'ffffff',
              :background => ['000000', '4a465a'],
              :marker => 'ffffff',
              :colors => %w(ffbbbb 00cc33 7788bb eeaa44 ffdd11 44bbdd dd6677)
            })
    end
  end  
  
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Vitamins < Base
    def initialize
      super({
              :background => ['000000', '4a465a'],
              :marker => 'ffffff',
              :colors => %w(cc9933 ffcc66 cccc99 cccc33 99cc33 3333cc 336699 6633cc 9999cc 333366)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Tulips < Base
    def initialize
      super({
              :background => ['670a0a', '831515'],
              :marker => 'dbd1c1',
              :colors => %w(f2c8ca bf545e d2808e 97985c b3b878 a24550)
            })
    end
  end
  
end