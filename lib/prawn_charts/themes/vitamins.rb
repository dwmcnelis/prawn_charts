
module PrawnCharts
  module Themes

    # Inspired by http://www.colorschemer.com/schemes/
    class Vitamins < Theme
      def initialize
        super({
          :background => ['000000', '4a465a'],
          :marker => 'ffffff',
          :colors => %w(cc9933 ffcc66 cccc99 cccc33 99cc33 3333cc 336699 6633cc 9999cc 333366)
        })
      end
    end

  end # Themes
end # PrawnCharts
