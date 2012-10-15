
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    class Label < Component
      def draw(pdf, bounds, options={})
        pdf.text(@options[:text],
          :class => 'text',
          :x => (bounds[:width] / 2),
          :y => bounds[:height],
          'font-size' => relative(100),
          'font-family' => options[:theme].font_family,
          :fill => options[:theme].marker,
          :stroke => 'none', 'stroke-width' => '0',
          'text-anchor' => (@options[:text_anchor] || 'middle'))
      end
    end # Label

  end # Components
end # PrawnCharts
