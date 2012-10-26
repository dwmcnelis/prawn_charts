
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Market76 theme
    class Market76 < Theme
      def initialize
        palette = {black: "000000", slate_blue40: "011e29", slate_blue20: "15323d", slate_blue: "294651", blue20: "3d5a65", blue40: "516e79", blue60: "65828d", blue80: "7996a1", blue100: "8daab5", blue140: "b5d2dd", blue160: "c9e6f1", pale_blue: "ccd0d2", paleblue20: "c9e6f1", paleblue30: "eaeef0", paleblue40: "f4f8fa", white: "ffffff"}
        super({
          :background => [palette[:paleblue40], palette[:white]],
          :marker => palette[:slate_blue],
          :title => palette[:slate_blue],
          :outlines => [palette[:slate_blue], palette[:blue100]],
          :colors => [palette[:slate_blue40], palette[:slate_blue], palette[:blue20], palette[:blue60], palette[:blue100], palette[:blue140], palette[:pale_blue], palette[:paleblue40], palette[:white]],
          :stacked_opacity => 0.85
        })
      end
    end # Market76

  end # Themes
end # PrawnCharts
