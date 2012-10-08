module PrawnCharts::Layers
  # Line graph.
  class Line < Base
    
    # Renders line graph.
    #
    # Options:
    # See initialize()
    def draw(pdf, coords, options={})
      
      # Include options provided when the object was created
      options.merge!(@options)
      
      stroke_width = (options[:relativestroke]) ? relative(options[:stroke_width]) : options[:stroke_width]
      style = (options[:style]) ? options[:style] : ''
      
      if options[:shadow]
        pdf.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
          pdf.polyline( :points => stringify_coords(coords).join(' '), :fill => 'transparent', 
                        :stroke => 'black', 'stroke-width' => stroke_width, 
                        :style => 'fill-opacity: 0; stroke-opacity: 0.35' )
          
          if options[:dots]
            coords.each { |coord| pdf.circle( :cx => coord.first, :cy => coord.last + relative(0.9), :r => stroke_width, 
                                              :style => "stroke-width: #{stroke_width}; stroke: black; opacity: 0.35;" ) }
          end
        }
      end
    

      pdf.polyline( :points => stringify_coords(coords).join(' '), :fill => 'none', :stroke => @color.to_s, 
                    'stroke-width' => stroke_width, :style => style  )
      
      if options[:dots]
        coords.each { |coord| pdf.circle( :cx => coord.first, :cy => coord.last, :r => stroke_width, 
                                          :style => "stroke-width: #{stroke_width}; stroke: #{color.to_s}; fill: #{color.to_s}" ) }
      end
      
    end
  end
end