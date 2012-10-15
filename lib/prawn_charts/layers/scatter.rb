
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Simple scatter graph
    class Scatter < Layer

      include PrawnCharts::Helpers::Marker

      # Renders scatter graph.
      def draw(pdf, coords, options={})

        options.merge!(@options)

        if options[:shadow]
          pdf.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
            coords.each { |coord| pdf.circle( :cx => coord.first, :cy => coord.last + relative(0.9), :r => relative(2),
              :style => "stroke-width: #{relative(2)}; stroke: black; opacity: 0.35;" ) }
          }
        end

        coords.each { |coord| pdf.circle( :cx => coord.first, :cy => coord.last, :r => relative(2),
          :style => "stroke-width: #{relative(2)}; stroke: #{color.to_s}; fill: #{color.to_s}" ) }
      end
    end # Scatter

  end # Layers
end # PrawnCharts
