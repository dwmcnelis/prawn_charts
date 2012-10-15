
require 'prawn_charts/themes/theme'

module PrawnCharts
  module Themes

    # Based on the color scheme used by almost every Ruby blogger.
    class RubyBlog < Theme
      def initialize
        super({
          :background => ['670a0a', '831515'],
          :marker => 'dbd1c1',
          :colors => %w(007777 444477 994444 77ffbb d75a20)
        })
      end
    end

  end # Themes
end # PrawnCharts
