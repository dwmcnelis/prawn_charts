
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Inspired by http://www.colorschemer.com/schemes/
    class Tulips < Theme
      def initialize
        super({
          :background => ['670a0a', '831515'],
          :marker => 'dbd1c1',
          :colors => %w(f2c8ca bf545e d2808e 97985c b3b878 a24550)
        })
      end
    end

  end # Themes
end # PrawnCharts
