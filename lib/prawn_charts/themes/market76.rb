
module PrawnCharts
  module Themes

    # Market76 theme
    class Market76 < Theme
      def initialize
        black = "000000"
        slate_blue40 = "011e29"
        slate_blue20 = "15323d"
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
        paleblue30 = "eaeef0"
        paleblue40 = "f4f8fa"
        white = "ffffff"
        super({
          :background => [paleblue30, white],
          :marker => slate_blue,
          :title => slate_blue,
          :outlines => [slate_blue,blue100],
          :colors => [slate_blue40, slate_blue, blue20, blue60, blue100, blue140, pale_blue, paleblue40, white]
        })
      end
    end # Market76

  end # Themes
end # PrawnCharts
