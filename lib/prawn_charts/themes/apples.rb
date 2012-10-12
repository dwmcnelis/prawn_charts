
module PrawnCharts
  module Themes

    # Inspired by http://www.colorschemer.com/schemes/
    class Apples < Theme
      def initialize
        super({
          :background => ['3b411f', '4a465a'],
          :marker => 'dbd1c1',
          :colors => %w(aa3322 dd3322 dd6644 ffee88 bbcc66 779933)
        })
      end
    end

  end # Themes
end # PrawnCharts
