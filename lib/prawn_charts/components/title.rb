module PrawnCharts
  module Components
    class Title < Base
      def draw(pdf, bounds, options={})
        #pdf.text_box "Title.draw bounds #{bounds}, options #{options}", :at => [10, 600]
        x = bounds[:width]/2
        y = bounds[:height]
        w = bounds[:width]
        pdf.fill_color "0000ff"
        pdf.text_box "title #{options[:title]}, x #{x}, y #{y}, w #{w}", :at => [10, 600]
        if options[:title]
          pdf.text_box options[:title], :at => [x,y], :width => w, :align => :center, :color => options[:theme].marker
          #pdf.text(options[:title],
          #  :class => 'title',
          #  :x => (bounds[:width] / 2),
          #  :y => bounds[:height],
          #  'font-size' => options[:theme].title_font_size || relative(100),
          #  'font-family' => options[:theme].font_family,
          #  :fill => options[:theme].marker,
          #  :stroke => 'none', 'stroke-width' => '0',
          #  'text-anchor' => (@options[:text_anchor] || 'middle'))
        end
      end
    end
  end
end