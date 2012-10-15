
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Default theme
    # Based on http://www.wellstyled.com/tools/colorscheme2/index-en.html?tetrad;50;0;255;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;0
    class Default < Theme
      def initialize
        super({
          :background => ['ffffff', 'ffffff'],
          :marker => '999999',
          :colors => %w(1919b3 ffb200 ffff00 660099 e9e9ff fff7e6 ffffe6 f7e6ff 0f0f6b 996b00 999900 3d005c)
        })

      end
    end

  end # Themes
end # PrawnCharts
