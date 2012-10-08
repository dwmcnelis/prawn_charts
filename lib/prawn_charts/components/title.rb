module PrawnCharts
  module Components
    class Title < Base
      def draw(pdf, bounds, options={})
        if options[:title]
          pdf.text(options[:title],
            :class => 'title',
            :x => (bounds[:width] / 2),
            :y => bounds[:height], 
            'font-size' => options[:theme].title_font_size || relative(100),
            'font-family' => options[:theme].font_family,
            :fill => options[:theme].marker,
            :stroke => 'none', 'stroke-width' => '0',
            'text-anchor' => (@options[:text_anchor] || 'middle'))
        end
      end
    end
  end
end