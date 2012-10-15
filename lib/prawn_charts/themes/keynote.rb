
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Keynote theme, based on Apple's Keynote presentation software.
    class Keynote < Theme
      def initialize
        super({
          :background => ['000000', '4a465a'],
          :marker => 'ffffff',
          :colors => %w(6886b4 fdd84e 72ae6e d1695e 8a6eaf efaa43 ffffff)
        })
      end
    end

  end # Themes
end # PrawnCharts
