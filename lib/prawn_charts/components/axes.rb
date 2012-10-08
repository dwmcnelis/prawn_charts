module PrawnCharts
  module Components
    class Axes < Base
      include PrawnCharts::Helpers::Marker
      
      def draw(pdf, bounds, options={})
        stroke_width = options[:stroke_width]
        
        colour = options[:theme].grid || options[:theme].marker
        unless options[:show_x] == false
          y = (options[:max_value] * bounds[:height])/(options[:max_value] - options[:min_value])
          pdf.line(:x1 => 0, :y1 => y, :x2 => bounds[:width], :y2 => y, :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
        end
        
        unless options[:show_y] == false
          x = -0.5
          pdf.line(:x1 => x, :y1 => 0, :x2 => x, :y2 => bounds[:height], :style => "stroke: #{colour.to_s}; stroke-width: #{stroke_width};")
        end
      end
    end
  end
end

