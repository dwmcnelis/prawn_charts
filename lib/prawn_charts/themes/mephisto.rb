
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Roughly, roughly based on the color scheme of www.mephistoblog.com.
    class Mephisto < Theme
      def initialize
        super({
          :background => ['101010', '999977'],
          :marker => 'ffffff',
          :colors => %w(dd3300 66aabb 225533 992200)
        })

      end
    end

  end # Themes
end # PrawnCharts
