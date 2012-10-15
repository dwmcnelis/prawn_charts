
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Inspired by http://www.colorschemer.com/schemes/
    class CareBears < Theme
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

  end # Themes
end # PrawnCharts
